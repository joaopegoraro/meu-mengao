import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/partida.dart';

import 'escudo_time.dart';

class Placar extends StatelessWidget {
  const Placar({
    super.key,
    required this.partida,
  });

  final Partida partida;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final textStyle = theme.textTheme.bodyLarge?.copyWith(
      color: colorScheme.onBackground,
      fontWeight: FontWeight.w600,
    );

    final subtextStyle = theme.textTheme.bodySmall?.copyWith(
      color: colorScheme.onBackground,
      fontWeight: FontWeight.w600,
    );

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF3F3F3),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          EscudoTime(escudo: partida.timeCasa.escudo),
          const Spacer(),
          Text(partida.timeCasa.nome, style: textStyle),
          const Spacer(),
          if (partida.golsCasa == null || partida.golsCasa! < 0)
            Text("vs", style: subtextStyle)
          else ...[
            Text("${partida.golsCasa}", style: textStyle),
            Text('-', style: subtextStyle),
            Text("${partida.golsFora}", style: textStyle),
          ],
          const Spacer(),
          Text(partida.timeFora.nome, style: textStyle),
          const Spacer(),
          EscudoTime(escudo: partida.timeFora.escudo),
        ],
      ),
    );
  }
}
