import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/time.dart';
import 'package:meu_mengao/ui/widgets/partida/escudo_time.dart';

class TabelaClassificacao extends StatelessWidget {
  const TabelaClassificacao({
    super.key,
    required this.times,
  });

  final List<Time> times;

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FractionColumnWidth(0.1),
        1: FractionColumnWidth(0.4),
        2: FractionColumnWidth(0.1),
        3: FractionColumnWidth(0.1),
        4: FractionColumnWidth(0.1),
        5: FractionColumnWidth(0.1),
        6: FractionColumnWidth(0.1),
      },
      children: [
        TableRow(
          children: const [
            Text("POS", textAlign: TextAlign.start),
            Text("CLUBE", textAlign: TextAlign.start),
            Text("V", textAlign: TextAlign.center),
            Text("E", textAlign: TextAlign.center),
            Text("D", textAlign: TextAlign.center),
            Text("SG", textAlign: TextAlign.center),
            Text("PTS", textAlign: TextAlign.center),
          ].map((text) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: text,
            );
          }).toList(),
        ),
        ...times.sortedBy((time) => time.posicao.toString()).mapIndexed((index, time) {
          final rows = [
            Text("${time.posicao}", textAlign: TextAlign.start),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                EscudoTime(escudo: time.escudo, height: 20),
                Text("\t${time.nome}"),
              ],
            ),
            Text("${time.vitorias}", textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.visible),
            Text("${time.empates}", textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.visible),
            Text("${time.derrotas}", textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.visible),
            Text("${time.saldoGols}", textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.visible),
            Text("${time.pontos}", textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.visible),
          ];

          const double spacing = 1.5;
          const spacingRow = TableRow(children: [
            SizedBox(height: spacing),
            SizedBox(height: spacing),
            SizedBox(height: spacing),
            SizedBox(height: spacing),
            SizedBox(height: spacing),
            SizedBox(height: spacing),
            SizedBox(height: spacing),
          ]);

          return [
            if (index != 0) spacingRow,
            TableRow(
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(4),
              ),
              children: rows.mapIndexed((index, widget) {
                final indexLastOrFirst = index == 0 || index == rows.length - 1;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: indexLastOrFirst ? 16 : 0, vertical: 8),
                  child: widget,
                );
              }).toList(),
            ),
            if (index != times.length - 1) spacingRow,
          ];
        }).flattened,
      ],
    );
  }
}
