import 'package:flutter/material.dart';

class DataPartida extends StatefulWidget {
  const DataPartida({
    super.key,
    required this.data,
    this.nomeCampeonato,
  });

  final String data;
  final String? nomeCampeonato;

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_month),
              Text(" ${widget.data}", style: textStyle),
            ],
          ),
          if (widget.nomeCampeonato != null && widget.nomeCampeonato!.isNotEmpty) ...[
            const Spacer(),
            Row(
              children: [
                const Icon(IconData(0xe800, fontFamily: "TrophyIcon")),
                Text(" ${widget.nomeCampeonato}", style: textStyle),
              ],
            ),
          ]
        ],
      ),
    );
  }
}
