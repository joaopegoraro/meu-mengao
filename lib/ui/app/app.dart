import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/noticia.dart';
import 'package:meu_mengao/data/models/partida.dart';
import 'package:meu_mengao/data/repositories/noticias_repository.dart';
import 'package:meu_mengao/data/repositories/partidas_repository.dart';
import 'package:meu_mengao/data/repositories/sites_repository.dart';
import 'package:meu_mengao/firebase_options.dart';
import 'package:url_launcher/url_launcher.dart';

class MeuMengaoApp extends StatelessWidget {
  const MeuMengaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Mengão',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: Future(() async {
          await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
          await FirebaseAuth.instance.signInAnonymously();
        }),
        builder: (context, snapshot) {
          if (snapshot.error != null) {
            return Placeholder(
              child: Text("ERRO: ${snapshot.error}"),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return const TestWidget();
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  final NoticiasRepository noticiasRepository = NoticiasRepositoryImpl();
  final SitesRepository sitesRepository = SitesRepositoryImpl();
  final PartidasRepository partidasRepository = PartidasRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
        [noticiasRepository.getNoticias(), partidasRepository.getProximaPartida()],
      ),
      builder: (context, snapshot) {
        final noticias = snapshot.data?[0] as List<Noticia>? ?? [];
        final proximaPartida = snapshot.data?[1] as Partida?;

        return SingleChildScrollView(
          child: Column(
            children: [
              if (proximaPartida != null)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          proximaPartida.escudoCasa == "FLAMENGO"
                              ? Image.asset(
                                  "assets/icons/flamengo.png",
                                  width: 40,
                                  height: 40,
                                )
                              : Image.memory(
                                  base64Decode(proximaPartida.escudoCasa!),
                                  width: 40,
                                  height: 40,
                                ),
                          Text(proximaPartida.timeCasa),
                          if (proximaPartida.golsCasa != null && proximaPartida.golsCasa! > 0)
                            Text("${proximaPartida.golsCasa!}"),
                          const Text(" - "),
                          if (proximaPartida.golsFora != null && proximaPartida.golsFora! > 0)
                            Text("${proximaPartida.golsFora!}"),
                          Text(proximaPartida.timeFora),
                          proximaPartida.escudoFora == "FLAMENGO"
                              ? Image.asset(
                                  "assets/icons/flamengo.png",
                                  width: 40,
                                  height: 40,
                                )
                              : Image.memory(
                                  base64Decode(proximaPartida.escudoFora!),
                                  width: 40,
                                  height: 40,
                                ),
                        ],
                      ),
                      if (proximaPartida.data != null) Text(proximaPartida.readableDate!),
                    ],
                  ),
                ),
              ...noticias.map((noticia) {
                return GestureDetector(
                  onTap: () {
                    final Uri url = Uri.parse(noticia.link);
                    launchUrl(url);
                  },
                  child: Column(
                    children: [
                      if (noticia.foto != null)
                        Image.memory(
                          base64Decode(noticia.foto!),
                          width: 40,
                          height: 40,
                        ),
                      Text(noticia.titulo),
                      FutureBuilder(
                        future: sitesRepository.getSiteWithId(noticia.siteId),
                        builder: (context, snapshot) {
                          final site = snapshot.data;

                          if (site?.logo != null) {
                            return Image.memory(
                              width: 20,
                              height: 20,
                              base64Decode(site!.logo!),
                            );
                          }

                          return const Icon(Icons.error);
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
