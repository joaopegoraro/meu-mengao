import 'package:flutter/material.dart';
import 'package:meu_mengao/data/repositories/campeonato_repository.dart';

class TelaTabelas extends StatefulWidget {
  const TelaTabelas({super.key});

  @override
  State<TelaTabelas> createState() => _TelaTabelasState();
}

class _TelaTabelasState extends State<TelaTabelas> {
  final CampeonatoRepository _campeonatoRepository = CampeonatoRepositoryImpl();
  String? campeonatoSelecionadoId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: _campeonatoRepository.getCampeonatos(),
        builder: (context, snapshot) {
          final campeonatos = snapshot.data;
          if (campeonatos?.isEmpty != false) {
            return const Placeholder();
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: DropdownButton(
                    isExpanded: true,
                    value: campeonatos!.first.id,
                    items: campeonatos.map((campeonato) {
                      return DropdownMenuItem<String>(
                        value: campeonato.id,
                        child: Text(campeonato.nome),
                      );
                    }).toList(),
                    onChanged: (id) {
                      setState(() => campeonatoSelecionadoId = id);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
