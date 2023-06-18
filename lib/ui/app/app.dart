import 'package:flutter/material.dart';
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
          home: const AppScaffold(),
        );
      },
    );
  }
}
