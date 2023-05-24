import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meu_mengao/data/repositories/campeonato_repository.dart';
import 'package:meu_mengao/data/repositories/noticias_repository.dart';
import 'package:meu_mengao/data/repositories/partidas_repository.dart';
import 'package:meu_mengao/data/repositories/sites_repository.dart';
import 'package:meu_mengao/firebase_options.dart';
import 'package:meu_mengao/ui/noticias/tela_noticias.dart';

class MeuMengaoApp extends StatelessWidget {
  const MeuMengaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Mengão',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFc22a1e),
          onPrimary: Colors.white,
        ),
        fontFamily: "Poppins",
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
    return const TelaNoticias();
  }
}
