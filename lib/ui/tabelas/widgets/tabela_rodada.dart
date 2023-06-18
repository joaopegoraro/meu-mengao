import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/partida.dart';

import '../../widgets/partida/partida_item.dart';

class TabelaRodada extends StatefulWidget {
  const TabelaRodada({
    super.key,
    required this.partidas,
    required this.indexInicial,
    required this.isLoading,
  });

  final List<Partida> partidas;
  final int indexInicial;
  final bool isLoading;

  @override
  State<TabelaRodada> createState() => TabelaRodadaState();
}

class TabelaRodadaState extends State<TabelaRodada> {
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.indexInicial;
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
    _pageIndex = widget.indexInicial;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return Column(
        children: List.generate(10, (_) {
          return const PartidaItem(
            partida: null,
            mostrarCampeonato: false,
          );
        }),
      );
    }

    final theme = Theme.of(context);

    final rodadas = widget.partidas
        .groupSetsBy<num>((partida) => partida.rodadaIndex ?? 0)
        .entries
        .sortedBy((rodada) => rodada.key)
        .toList();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Icon(
                Icons.arrow_left,
                color: theme.colorScheme.onBackground,
              ),
              onTap: () {
                final newIndex = _pageIndex - 1;
                if (newIndex >= 0 && newIndex < rodadas.length) {
                  setState(() => _pageIndex = newIndex);
                }
              },
            ),
            Expanded(
              child: Text(
                rodadas[_pageIndex].value.first.rodadaName ?? "",
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium,
              ),
            ),
            GestureDetector(
              child: Icon(
                Icons.arrow_right,
                color: theme.colorScheme.onBackground,
              ),
              onTap: () {
                final newIndex = _pageIndex + 1;
                if (newIndex >= 0 && newIndex < rodadas.length) {
                  setState(() => _pageIndex = newIndex);
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        ...rodadas[_pageIndex]
            .value
            .sortedByCompare((element) => element, (a, b) => a.timeCasa.compareTo(b.timeFora))
            .map((partida) {
          return PartidaItem(partida: partida, mostrarCampeonato: false);
        }),
      ],
    );
  }
}
