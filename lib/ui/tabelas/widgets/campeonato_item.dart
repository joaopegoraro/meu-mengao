import 'package:flutter/material.dart';

import '../../../data/models/campeonato.dart';

class CampeonatoItem extends StatefulWidget {
  const CampeonatoItem({
    super.key,
    required this.campeonatoId,
  });

  final String? campeonatoId;

  @override
  State<CampeonatoItem> createState() => CampeonatoItemState();
}

class CampeonatoItemState extends State<CampeonatoItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.campeonatoId?.isEmpty != false) {
      return const Placeholder(
        color: Colors.green,
      );
    }

    return FutureBuilder(
      future: null,
      builder: (context, snapshot) {
        final Campeonato? campeonato = null;
        return Placeholder();

//        if (campeonato?.hasData != true) {
//          return const Placeholder(
//            color: Colors.red,
//          );
//        }
//
//        return Column(
//          children: [
//            if (campeonato!.classificacao.isNotEmpty) TabelaClassificacao(times: campeonato.classificacao),
//            if (campeonato.mataMata.isNotEmpty) const TabelaMataMata(),
//          ],
//        );
      },
    );
  }
}
