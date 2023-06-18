import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/partida.dart';
import 'package:shimmer/shimmer.dart';

import 'data_partida.dart';
import 'placar.dart';

class PartidaItem extends StatelessWidget {
  const PartidaItem({
    super.key,
    required this.partida,
    required this.mostrarCampeonato,
  });

  final Partida? partida;
  final bool mostrarCampeonato;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.background,
      child: Column(
        children: [
          if (partida == null)
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: theme.colorScheme.background,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      height: 60.0,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    Container(
                      height: 60.0,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          if (partida != null) ...[
            Placar(partida: partida!),
            DataPartida(
              data: partida!.readableDate,
              horario: partida!.horario,
              nomeCampeonato: mostrarCampeonato ? partida!.campeonato : null,
              nomeRodada: mostrarCampeonato ? partida!.rodadaName : null,
            ),
          ],
        ],
      ),
    );
  }
}
