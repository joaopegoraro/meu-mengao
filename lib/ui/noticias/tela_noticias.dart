import 'package:flutter/material.dart';
import 'package:meu_mengao/ui/noticias/widgets/lista_noticias.dart';
import 'package:meu_mengao/ui/noticias/widgets/topbar.dart';

class TelaNoticias extends StatelessWidget {
  const TelaNoticias({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TopBar(),
        ListaNoticias(),
      ],
    );
  }
}
