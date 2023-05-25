import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/partida.dart';
import 'package:meu_mengao/data/repositories/partidas_repository.dart';
import 'package:meu_mengao/ui/widgets/partida/lista_partidas.dart';

class TelaResultados extends StatefulWidget {
  const TelaResultados({super.key});

  @override
  State<TelaResultados> createState() => _TelaResultadosState();
}

class _TelaResultadosState extends State<TelaResultados> with AutomaticKeepAliveClientMixin<TelaResultados> {
  final PartidasRepository _partidasRepository = PartidasRepositoryImpl();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Expanded(
      child: FutureBuilder(
        future: _partidasRepository.getResultados(),
        builder: (context, snapshot) {
          final List<Partida> partidas =
              snapshot.data != null ? List.filled(10, snapshot.data!.first).whereNotNull().toList() : [];

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
