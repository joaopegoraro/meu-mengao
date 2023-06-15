import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/campeonato.dart';
import 'package:meu_mengao/ui/tabelas/widgets/campeonato_item.dart';

import '../../data/api/api_service.dart';

class TelaTabelas extends StatefulWidget {
  const TelaTabelas({super.key});

  @override
  State<TelaTabelas> createState() => _TelaTabelasState();
}

class _TelaTabelasState extends State<TelaTabelas> with AutomaticKeepAliveClientMixin<TelaTabelas> {
  final ApiService _apiService = ApiService();

  String? campeonatoSelecionadoId;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Expanded(
        child: FutureBuilder(
          future: _apiService.getCampeonatos().then((campeonatos) {
            campeonatoSelecionadoId ??= campeonatos?.first.id;
            return campeonatos;
          }),
          builder: (context, snapshot) {
            final List<Campeonato> campeonatos = snapshot.data ?? [];
            if (campeonatos.isEmpty != false) {
              return const Placeholder();
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  DropdownButton(
                    isExpanded: true,
                    value: campeonatoSelecionadoId,
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
                  CampeonatoItem(campeonatoId: campeonatoSelecionadoId),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
