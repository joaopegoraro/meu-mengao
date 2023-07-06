import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_mengao/ui/app/widgets/app_scaffold.dart';
import 'package:meu_mengao/ui/notifiers/dark_mode_notifier.dart';
import 'package:sizer/sizer.dart';

class MeuMengaoApp extends ConsumerWidget {
  const MeuMengaoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkModeNotifier = ref.watch(darkModeNotifierProvider);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Meu Mengão',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFc22a1e),
              primary: const Color(0xFFc22a1e),
              onPrimary: Colors.white,
              surface: const Color(0xFFF3F3F3),
              background: Colors.white,
            ),
            fontFamily: "Poppins",
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFc22a1e),
              primary: const Color(0xFFc22a1e),
              onPrimary: Colors.black,
              onSurface: Colors.white,
              surface: const Color.fromARGB(255, 22, 22, 22),
              background: Colors.black,
              onBackground: Colors.white,
            ),
            fontFamily: "Poppins",
            useMaterial3: true,
          ),
          themeMode: darkModeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const AppScaffold(),
        );
      },
    );
  }
}
