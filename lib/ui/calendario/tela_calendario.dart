import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/partida.dart';
import 'package:meu_mengao/ui/widgets/partida/lista_partidas.dart';

import '../../data/api/api_service.dart';

class TelaCalendario extends StatefulWidget {
  const TelaCalendario({super.key});

  @override
  State<TelaCalendario> createState() => _TelaCalendarioState();
}

class _TelaCalendarioState extends State<TelaCalendario> with AutomaticKeepAliveClientMixin<TelaCalendario> {
  final ApiService _apiService = ApiService();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Expanded(
      child: FutureBuilder(
        future: _apiService.getCalendario(),
        builder: (context, snapshot) {
          final List<Partida> partidas = snapshot.data ?? [];

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
