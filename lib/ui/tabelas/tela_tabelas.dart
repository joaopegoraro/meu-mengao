import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/campeonato.dart';
import 'package:meu_mengao/data/repositories/campeonatos_repository.dart';
import 'package:meu_mengao/ui/tabelas/widgets/campeonato_item.dart';

class TelaTabelas extends StatefulWidget {
  const TelaTabelas({super.key});

  @override
  State<TelaTabelas> createState() => _TelaTabelasState();
}

class _TelaTabelasState extends State<TelaTabelas> with AutomaticKeepAliveClientMixin<TelaTabelas> {
  final CampeonatosRepository _campeonatosRepository = CampeonatosRepository();

  Campeonato? campeonatoSelecionado;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Expanded(
      child: FutureBuilder(
        future: _campeonatosRepository.getAll().then((campeonatos) {
          campeonatoSelecionado ??= campeonatos.first;
          return campeonatos;
        }),
        builder: (context, snapshot) {
          final List<Campeonato> campeonatos = snapshot.data ?? [];
          if (campeonatos.isEmpty != false) {
            return const Placeholder();
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  DropdownButton(
                    isExpanded: true,
                    value: campeonatoSelecionado?.id,
                    items: campeonatos.map((campeonato) {
                      return DropdownMenuItem<String>(
                        value: campeonato.id,
                        child: Expanded(
                          child: Text(
                            campeonato.nome,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (id) {
                      setState(() {
                        campeonatoSelecionado = campeonatos.firstWhere((campeonato) {
                          return campeonato.id == id;
                        });
                      });
                    },
                  ),
                  CampeonatoItem(campeonato: campeonatoSelecionado),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
