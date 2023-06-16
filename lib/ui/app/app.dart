import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl_standalone.dart';
import 'package:meu_mengao/data/repositories/auth_repository.dart';
import 'package:meu_mengao/firebase_options.dart';
import 'package:meu_mengao/ui/app/widgets/app_scaffold.dart';
import 'package:sizer/sizer.dart';

class MeuMengaoApp extends StatelessWidget {
  const MeuMengaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Meu Mengão',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFc22a1e),
              primary: const Color(0xFFc22a1e),
              onPrimary: Colors.white,
            ),
            fontFamily: "Poppins",
            useMaterial3: true,
          ),
          home: FutureBuilder(
            future: Future(() async {
              await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
              final authData = await FirebaseAuth.instance.signInAnonymously();
              final token = await authData.user?.getIdToken();
              if (token != null) {
                await AuthRepository().saveToken(token);
              }
              await initializeDateFormatting(await findSystemLocale(), null);
            }),
            builder: (context, snapshot) {
              if (snapshot.error != null) {
                return Placeholder(
                  child: Text("ERRO: ${snapshot.error}"),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return const AppScaffold();
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
    );
  }
}
