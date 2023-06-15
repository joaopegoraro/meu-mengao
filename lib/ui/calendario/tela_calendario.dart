import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/partida.dart';
import 'package:meu_mengao/ui/widgets/partida/lista_partidas.dart';

class TelaCalendario extends StatefulWidget {
  const TelaCalendario({super.key});

  @override
  State<TelaCalendario> createState() => _TelaCalendarioState();
}

class _TelaCalendarioState extends State<TelaCalendario> with AutomaticKeepAliveClientMixin<TelaCalendario> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Expanded(
      child: FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          final List<Partida> partidas = [];

          if (partidas.isEmpty || snapshot.hasError) return const Center(child: CircularProgressIndicator());

          return ListaPartidas(
            partidas: partidas,
            mostrarCampeonato: true,
          );
        },
      ),
    );
  }
}
