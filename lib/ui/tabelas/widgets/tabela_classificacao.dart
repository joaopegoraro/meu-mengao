import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/posicao.dart';
import 'package:meu_mengao/ui/widgets/partida/escudo_time.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../data/models/rodada.dart';

class TabelaClassificacao extends StatelessWidget {
  const TabelaClassificacao({
    super.key,
    required this.classificacao,
    required this.isLoading,
  });

  final List<Posicao> classificacao;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.white,
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF3F3F3),
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          padding: const EdgeInsets.all(15),
          child: Container(
            height: 80.h,
            width: double.infinity,
            color: Colors.grey,
          ),
        ),
      );
    }

    final theme = Theme.of(context);
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
            if (rodadasComPosicoes.length > 1)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  rodada.nome,
                  style: theme.textTheme.labelMedium,
                ),
              ),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FractionColumnWidth(0.025),
                2: FractionColumnWidth(0.35),
                9: FractionColumnWidth(0.025),
              },
              children: [
                TableRow(
                  children: ["", "", "CLUBE", "J", "V", "E", "D", "SG", "P", ""].map((text) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        text,
                        textAlign: text == "CLUBE" ? TextAlign.start : TextAlign.center,
                        overflow: TextOverflow.visible,
                        maxLines: 1,
                        style: theme.textTheme.labelSmall,
                      ),
                    );
                  }).toList(),
                ),
                ...posicoes.sortedBy<num>((time) => time.posicao).mapIndexed(
                  (index, time) {
                    const double horizontalSpacing = 1.5;
                    const spacingColumn = SizedBox(width: horizontalSpacing);
                    final rows = [
                      spacingColumn,
                      Text("${time.posicao}",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          EscudoTime(escudo: time.escudoTime, height: 20),
                          Flexible(
                            child: Text(
                              "\t${time.nomeTime}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: time.nomeTime == "Flamengo" ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ...[time.jogos, time.vitorias, time.empates, time.derrotas, time.saldoGols].map((text) {
                        return Text(
                          text,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                          style: theme.textTheme.bodySmall,
                        );
                      }),
                      Text(
                        time.pontos,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      spacingColumn,
                    ];

                    const double verticalSpacing = 1.5;
                    const spacingRow = TableRow(children: [
                      SizedBox(height: verticalSpacing),
                      SizedBox(height: verticalSpacing),
                      SizedBox(height: verticalSpacing),
                      SizedBox(height: verticalSpacing),
                      SizedBox(height: verticalSpacing),
                      SizedBox(height: verticalSpacing),
                      SizedBox(height: verticalSpacing),
                      SizedBox(height: verticalSpacing),
                      SizedBox(height: verticalSpacing),
                      SizedBox(height: verticalSpacing),
                    ]);

                    return [
                      if (index != 0) spacingRow,
                      TableRow(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        children: rows.mapIndexed((index, widget) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
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
