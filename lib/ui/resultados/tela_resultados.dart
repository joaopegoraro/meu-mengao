import 'package:flutter/material.dart';
import 'package:meu_mengao/ui/providers/resultados_provider.dart';
import 'package:meu_mengao/ui/widgets/partida/lista_partidas.dart';
import 'package:provider/provider.dart';

class TelaResultados extends StatefulWidget {
  const TelaResultados({super.key});

  @override
  State<TelaResultados> createState() => _TelaResultadosState();
}

class _TelaResultadosState extends State<TelaResultados> with AutomaticKeepAliveClientMixin<TelaResultados> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ResultadosProvider>().listarResultados();
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ResultadosProvider>(
      builder: (context, provider, _) {
        final resultados = provider.resultados;
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
