import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
            return const Placeholder();
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
