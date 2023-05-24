import 'package:flutter/material.dart';
import 'package:meu_mengao/ui/noticias/widgets/proxima_partida.dart';
import 'package:meu_mengao/ui/noticias/widgets/topbar.dart';

class TelaNoticias extends StatelessWidget {
  const TelaNoticias({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          TopBar(),
          ProximaPartida(),
        ],
      ),
    );
  }
}