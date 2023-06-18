import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_mengao/ui/notifiers/campeonatos_notifier.dart';
import 'package:meu_mengao/ui/notifiers/proxima_partida_notifier.dart';
import 'package:meu_mengao/ui/tabelas/widgets/campeonato_item.dart';

class TelaTabelas extends ConsumerStatefulWidget {
  const TelaTabelas({super.key});

  @override
  ConsumerState<TelaTabelas> createState() => _TelaTabelasState();
}

class _TelaTabelasState extends ConsumerState<TelaTabelas> with AutomaticKeepAliveClientMixin<TelaTabelas> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final campeonatosProvider = ref.read(campeonatosNotifierProvider);
      final proximaPartida = ref.read(proximaPartidaNotifierProvider).proximaPartida;
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

    final notifier = ref.watch(campeonatosNotifierProvider);
    final campeonatos = notifier.campeonatos;
    final campeonatoSelecionado = notifier.campeonatoSelecionado;
    final isLoading = notifier.isLoading;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (campeonatos.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(50.0),
        child: Center(
          child: Text(
            "Não foi encontrado nehum campeonato.",
            textAlign: TextAlign.center,
          ),
        ),
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
              onChanged: (id) => notifier.setCampeonatoSelecionado(id),
            ),
            CampeonatoItem(
              key: Key(campeonatoSelecionado?.id ?? ""),
              campeonato: campeonatoSelecionado,
            ),
          ],
        ),
      ),
    );
  }
}
