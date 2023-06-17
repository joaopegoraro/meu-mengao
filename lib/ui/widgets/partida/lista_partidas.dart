import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meu_mengao/data/models/partida.dart';
import 'package:meu_mengao/ui/widgets/partida/partida_item.dart';

class ListaPartidas extends StatelessWidget {
  const ListaPartidas({
    super.key,
    required this.partidas,
    required this.mostrarCampeonato,
  });

  final List<Partida?> partidas;
  final bool mostrarCampeonato;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      itemCount: partidas.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final partida = partidas[index];
        final dataPartida = partida?.data;
        final primeiraPartida = index == 0;
        final primeiraPartidaDoMes =
            dataPartida != null && index >= 1 && partidas[index - 1]?.data?.month != partida?.data?.month;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: Column(
            children: [
              if (partida != null && (primeiraPartida || primeiraPartidaDoMes))
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      DateFormat.MMMM(Platform.localeName).format(dataPartida!).toUpperCase(),
                      textAlign: TextAlign.start,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ),
              PartidaItem(
                partida: partidas[index],
                mostrarCampeonato: true,
              ),
            ],
          ),
        );
      },
    );
  }
}
