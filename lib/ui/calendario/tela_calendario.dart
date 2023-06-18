import 'package:flutter/material.dart';
import 'package:meu_mengao/ui/providers/calendario_provider.dart';
import 'package:meu_mengao/ui/widgets/partida/lista_partidas.dart';
import 'package:provider/provider.dart';

class TelaCalendario extends StatefulWidget {
  const TelaCalendario({super.key});

  @override
  State<TelaCalendario> createState() => _TelaCalendarioState();
}

class _TelaCalendarioState extends State<TelaCalendario> with AutomaticKeepAliveClientMixin<TelaCalendario> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CalendarioProvider>().listarCalendario();
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<CalendarioProvider>(
      builder: (context, provider, _) {
        final resultados = provider.calendario;
        final isLoading = provider.isLoading;

        if (!isLoading && resultados.isEmpty) {
          return const Center(
            child: Text("Não foi encontrada nenhuma partida."),
          );
        }

        return ListaPartidas(
          partidas: isLoading ? List.generate(10, (_) => null) : resultados,
          mostrarCampeonato: true,
        );
      },
    );
  }
}
