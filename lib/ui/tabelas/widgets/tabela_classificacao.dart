import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/time.dart';
import 'package:meu_mengao/ui/widgets/partida/escudo_time.dart';

class TabelaClassificacao extends StatefulWidget {
  const TabelaClassificacao({
    super.key,
    required this.times,
  });

  final List<Time> times;

  @override
  State<TabelaClassificacao> createState() => TabelaClassificacaoState();
}

class TabelaClassificacaoState extends State<TabelaClassificacao> {
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
        const TableRow(
          children: [
            Text("POS", textAlign: TextAlign.start),
            Text("CLUBE", textAlign: TextAlign.start),
            Text("V", textAlign: TextAlign.center),
            Text("E", textAlign: TextAlign.center),
            Text("D", textAlign: TextAlign.center),
            Text("SG", textAlign: TextAlign.center),
            Text("PTS", textAlign: TextAlign.center),
          ],
        ),
        ...widget.times.sortedBy((time) => time.posicao.toString()).map((time) {
          return TableRow(
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.circular(4),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text("${time.posicao}", textAlign: TextAlign.start),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  EscudoTime(escudo: time.escudo, height: 20),
                  Text("\t${time.nome}"),
                ],
              ),
              ...[
                Text("${time.vitorias}", textAlign: TextAlign.center),
                Text("${time.empates}", textAlign: TextAlign.center),
                Text("${time.derrotas}", textAlign: TextAlign.center),
                Text("${time.saldoGols}", textAlign: TextAlign.center),
                Text("${time.pontos}", textAlign: TextAlign.center),
              ].map((text) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: text,
                );
              }),
            ],
          );
        }),
      ],
    );
  }
}
