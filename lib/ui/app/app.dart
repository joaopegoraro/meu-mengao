import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meu_mengao/data/repositories/campeonato_repository.dart';
import 'package:meu_mengao/data/repositories/noticias_repository.dart';
import 'package:meu_mengao/data/repositories/partidas_repository.dart';
import 'package:meu_mengao/data/repositories/sites_repository.dart';
import 'package:meu_mengao/firebase_options.dart';

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
  final CampeonatoRepository campeonatoRepository = CampeonatoRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: campeonatoRepository.getCampeonatos(),
      builder: (context, snapshot) {
        final campeonatos = snapshot.data;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: campeonatos?.map((campeonato) {
                  return FutureBuilder(
                    future: campeonatoRepository.getCampeonatoWithId(campeonato.id),
                    builder: (context, snapshot) {
                      final campeonato = snapshot.data;
                      if (campeonato == null) return const Center(child: CircularProgressIndicator());
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: campeonato.classificacao.sortedBy((time) => time.posicao.toString()).map((time) {
                          return Row(
                            children: [
                              Text("${time.posicao}"),
                              time.escudo != null && time.escudo!.isNotEmpty && time.escudo != "FLAMENGO"
                                  ? Image.memory(
                                      base64Decode(time.escudo!),
                                      width: 40,
                                      height: 40,
                                    )
                                  : Image.asset(
                                      "assets/icons/flamengo.png",
                                      width: 40,
                                      height: 40,
                                    ),
                              Text(time.nome),
                              Column(
                                children: [
                                  const Text("P"),
                                  Text("${time.pontos}"),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text("V"),
                                  Text("${time.vitorias}"),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text("E"),
                                  Text("${time.empates}"),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text("D"),
                                  Text("${time.derrotas}"),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text("GM"),
                                  Text("${time.golsFeitos}"),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text("GC"),
                                  Text("${time.golsSofridos}"),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text("SG"),
                                  Text("${time.saldoGols}"),
                                ],
                              ),
                            ],
                          );
                        }).toList(),
                      );
                    },
                  );
                }).toList() ??
                [],
          ),
        );
      },
    );
  }
}
