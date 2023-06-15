import 'package:flutter/material.dart';

class DataPartida extends StatefulWidget {
  const DataPartida({
    super.key,
    required this.data,
    this.nomeCampeonato,
    this.nomeRodada,
  });

  final String data;
  final String? nomeCampeonato;
  final String? nomeRodada;

  @override
  State<DataPartida> createState() => _DataPartidaState();
}

class _DataPartidaState extends State<DataPartida> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final textStyle = theme.textTheme.labelLarge?.copyWith(
      color: colorScheme.onBackground,
      fontWeight: FontWeight.w400,
    );

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.background,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.calendar_month),
                Expanded(child: Text("\t${widget.data}", style: textStyle)),
              ],
            ),
          ),
          if (widget.nomeCampeonato != null && widget.nomeCampeonato!.isNotEmpty) ...[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(),
                  const Icon(IconData(0xe800, fontFamily: "TrophyIcon")),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Text(
                          "\t${widget.nomeCampeonato}",
                          textAlign: TextAlign.center,
                          style: textStyle,
                        ),
                        Text(
                          "\t${widget.nomeRodada}",
                          textAlign: TextAlign.center,
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }
}
