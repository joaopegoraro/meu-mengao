import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/partida.dart';
import 'package:meu_mengao/ui/widgets/partida/partida_item.dart';

class TabelaRodada extends StatefulWidget {
  const TabelaRodada({
    super.key,
    required this.partidas,
  });

  final List<Partida> partidas;

  @override
  State<TabelaRodada> createState() => TabelaRodadaState();
}

class TabelaRodadaState extends State<TabelaRodada> {
  int _pageIndex = 0;
  late final PageController _pagerController;

  @override
  void initState() {
    super.initState();

    _pagerController = PageController(
      initialPage: _pageIndex,
      keepPage: true,
    );
  }

  @override
  void dispose() {
    _pagerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              child: const Icon(Icons.arrow_left),
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
              child: const Icon(Icons.arrow_right),
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
        Column(
          children: rodadas.first.value.map((partida) {
            return PartidaItem(partida: partida, mostrarCampeonato: false);
          }).toList(),
        ),
      ],
      //PageView(
      //  controller: _pagerController,
      //  onPageChanged: (index) => setState(() {
      //    _pageIndex = index;
      //  }),
      //  children: rodadas.map((rodada) {
      //    final partidas = rodada.value;
      //    return Column(
      //      children: partidas.map((partida) {
      //        return PartidaItem(partida: partida, mostrarCampeonato: true);
      //      }).toList(),
      //    );
      //  }).toList(),
      //),
    );
  }
}
