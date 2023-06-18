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
      color: colorScheme.onSurface,
      fontWeight: FontWeight.w600,
    );

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EscudoTime(escudo: partida.escudoCasa),
              Expanded(
                child: Text(
                  "\t${partida.timeCasa}",
                  style: textStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              if (partida.golsCasa != null) Text("${partida.golsCasa}", style: textStyle),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EscudoTime(escudo: partida.escudoFora),
              Expanded(
                child: Text(
                  "\t${partida.timeFora}",
                  style: textStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              if (partida.golsFora != null) Text("${partida.golsFora}", style: textStyle),
            ],
          ),
        ],
      ),
    );
  }
}
