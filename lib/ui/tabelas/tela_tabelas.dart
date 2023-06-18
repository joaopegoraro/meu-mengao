import 'package:flutter/material.dart';
import 'package:meu_mengao/ui/providers/campeonatos_provider.dart';
import 'package:meu_mengao/ui/providers/proxima_partida_provider.dart';
import 'package:meu_mengao/ui/tabelas/widgets/campeonato_item.dart';
import 'package:provider/provider.dart';

class TelaTabelas extends StatefulWidget {
  const TelaTabelas({super.key});

  @override
  State<TelaTabelas> createState() => _TelaTabelasState();
}

class _TelaTabelasState extends State<TelaTabelas> with AutomaticKeepAliveClientMixin<TelaTabelas> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final campeonatosProvider = context.read<CampeonatosProvider>();
      final proximaPartida = context.read<ProximaPartidaProvider>().proximaPartida;
      campeonatosProvider.listarCampeonatos().then((_) {
        campeonatosProvider.setCampeonatoSelecionado(proximaPartida?.campeonatoId);
      });
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Consumer<CampeonatosProvider>(
      builder: (context, campeonatosProvider, _) {
        final campeonatos = campeonatosProvider.campeonatos;
        final campeonatoSelecionado = campeonatosProvider.campeonatoSelecionado;
        final isLoading = campeonatosProvider.isLoading;

        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (campeonatos.isEmpty) {
          return const Center(
            child: Text("Não foi encontrado nehum campeonato."),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                DropdownButton(
                  isExpanded: true,
                  value: campeonatoSelecionado?.id ?? campeonatos.firstOrNull?.id,
                  items: campeonatos.map((campeonato) {
                    return DropdownMenuItem<String>(
                      value: campeonato.id,
                      child: Text(
                        campeonato.nome,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (id) => campeonatosProvider.setCampeonatoSelecionado(id),
                ),
                CampeonatoItem(
                  key: Key(campeonatoSelecionado?.id ?? ""),
                  campeonato: campeonatoSelecionado,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
