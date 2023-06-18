import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_mengao/ui/notifiers/resultados_notifier.dart';
import 'package:meu_mengao/ui/widgets/partida/lista_partidas.dart';

class TelaResultados extends ConsumerStatefulWidget {
  const TelaResultados({super.key});

  @override
  ConsumerState<TelaResultados> createState() => _TelaResultadosState();
}

class _TelaResultadosState extends ConsumerState<TelaResultados> with AutomaticKeepAliveClientMixin<TelaResultados> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(resultadosNotifierProvider).listarResultados();
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final notifier = ref.watch(resultadosNotifierProvider);
    final resultados = notifier.resultados;
    final isLoading = notifier.isLoading;

    if (!isLoading && resultados.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(50.0),
        child: Center(
          child: Text(
            "Não foi encontrada nenhuma partida.",
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListaPartidas(
      partidas: isLoading ? List.generate(10, (_) => null) : resultados,
      mostrarCampeonato: true,
    );
  }
}
