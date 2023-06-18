import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_mengao/ui/notifiers/calendario_notifier.dart';
import 'package:meu_mengao/ui/widgets/partida/lista_partidas.dart';

class TelaCalendario extends ConsumerStatefulWidget {
  const TelaCalendario({super.key});

  @override
  ConsumerState<TelaCalendario> createState() => _TelaCalendarioState();
}

class _TelaCalendarioState extends ConsumerState<TelaCalendario> with AutomaticKeepAliveClientMixin<TelaCalendario> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(calendarioNotifierProvider).listarCalendario();
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final notifier = ref.watch(calendarioNotifierProvider);
    final resultados = notifier.calendario;
    final isLoading = notifier.isLoading;

    if (!isLoading && resultados.isEmpty) {
      return const Center(
        child: Text("Não foi encontrada nenhuma partida."),
      );
    }

    return ListaPartidas(
      partidas: isLoading ? List.generate(10, (_) => null) : resultados,
      mostrarCampeonato: true,
    );
  }
}
