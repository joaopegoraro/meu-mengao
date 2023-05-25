import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/partida.dart';
import 'package:meu_mengao/ui/widgets/partida/partida_item.dart';

class ListaPartidas extends StatelessWidget {
  const ListaPartidas({
    super.key,
    required this.partidas,
    required this.mostrarCampeonato,
  });

  final List<Partida> partidas;
  final bool mostrarCampeonato;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: partidas.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: PartidaItem(
            partida: partidas[index],
            mostrarCampeonato: true,
          ),
        );
      },
    );
  }
}
