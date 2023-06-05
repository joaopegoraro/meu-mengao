import 'package:flutter/material.dart';
import 'package:meu_mengao/data/repositories/campeonato_repository.dart';
import 'package:meu_mengao/ui/tabelas/widgets/campeonato_item.dart';

class TelaTabelas extends StatefulWidget {
  const TelaTabelas({super.key});

  @override
  State<TelaTabelas> createState() => _TelaTabelasState();
}

class _TelaTabelasState extends State<TelaTabelas> with AutomaticKeepAliveClientMixin<TelaTabelas> {
  final CampeonatoRepository _campeonatoRepository = CampeonatoRepositoryImpl();
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
          future: _campeonatoRepository.getCampeonatos().then((campeonatos) {
            campeonatoSelecionadoId = campeonatos.first.id;
            return campeonatos;
          }),
          builder: (context, snapshot) {
            final campeonatos = snapshot.data;
            if (campeonatos?.isEmpty != false) {
              return const Placeholder();
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  DropdownButton(
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