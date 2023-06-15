import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/posicao.dart';
import 'package:meu_mengao/ui/widgets/partida/escudo_time.dart';

import '../../../data/models/rodada.dart';

class TabelaClassificacao extends StatelessWidget {
  const TabelaClassificacao({
    super.key,
    required this.classificacao,
  });

  final List<Posicao> classificacao;

  @override
  Widget build(BuildContext context) {
    final rodadasComPosicoes = classificacao
        .groupListsBy((posicao) {
          return Rodada(
            nome: posicao.classificacaoName,
            index: posicao.classificacaoIndex,
          );
        })
        .entries
        .sortedBy((rodada) => rodada.key.index.toString());

    return Column(
      children: rodadasComPosicoes.map((rodadaComPosicoes) {
        final rodada = rodadaComPosicoes.key;
        final posicoes = rodadaComPosicoes.value;
        return Column(
          children: [
            if (rodadasComPosicoes.length > 1) Text(rodada.nome),
            Table(
              columnWidths: const {
                0: FractionColumnWidth(0.1),
                1: FractionColumnWidth(0.4),
                2: FractionColumnWidth(0.08),
                3: FractionColumnWidth(0.08),
                4: FractionColumnWidth(0.08),
                5: FractionColumnWidth(0.08),
                6: FractionColumnWidth(0.08),
                7: FractionColumnWidth(0.1),
              },
              children: [
                TableRow(
                  children: const [
                    Text("POS", textAlign: TextAlign.start),
                    Text("CLUBE", textAlign: TextAlign.start),
                    Text("J", textAlign: TextAlign.center),
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
                ...posicoes.sortedBy<num>((time) => time.posicao).mapIndexed(
                  (index, time) {
                    final rows = [
                      Text("${time.posicao}", textAlign: TextAlign.start),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          EscudoTime(escudo: time.escudoTime, height: 20),
                          Text("\t${time.nomeTime}"),
                        ],
                      ),
                      Text(time.jogos, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.visible),
                      Text(time.vitorias, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.visible),
                      Text(time.empates, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.visible),
                      Text(time.derrotas, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.visible),
                      Text(time.saldoGols, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.visible),
                      Text(time.pontos, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.visible),
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
                      if (index != classificacao.length - 1) spacingRow,
                    ];
                  },
                ).flattened,
              ],
            ),
          ],
        );
      }).toList(),
    );
  }
}
