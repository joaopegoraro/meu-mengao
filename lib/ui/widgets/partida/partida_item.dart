import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/partida.dart';

import 'data_partida.dart';
import 'placar.dart';

class PartidaItem extends StatelessWidget {
  const PartidaItem({
    super.key,
    required this.partida,
    required this.mostrarCampeonato,
  });

  final Partida partida;
  final bool mostrarCampeonato;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Placar(partida: partida),
          DataPartida(
            data: partida.readableDate ?? "",
            nomeCampeonato: mostrarCampeonato ? partida.campeonato : null,
          ),
        ],
      ),
    );
  }
}
