import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/campeonato.dart';
import 'package:meu_mengao/ui/tabelas/widgets/campeonato_item.dart';

class TelaTabelas extends StatefulWidget {
  const TelaTabelas({super.key});

  @override
  State<TelaTabelas> createState() => _TelaTabelasState();
}

class _TelaTabelasState extends State<TelaTabelas> with AutomaticKeepAliveClientMixin<TelaTabelas> {
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
          future: null,
          builder: (context, snapshot) {
            final List<Campeonato> campeonatos = [];
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
