import 'package:flutter/material.dart';

class DataPartida extends StatefulWidget {
  const DataPartida({
    super.key,
    required this.data,
    this.nomeCampeonato,
    this.nomeRodada,
    required this.horario,
  });

  final String data;
  final String horario;
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

    final mostrarCampeonato = widget.nomeCampeonato != null && widget.nomeCampeonato!.isNotEmpty;

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
          if (mostrarCampeonato) ...[
            Expanded(
              flex: 18,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(IconData(0xe800, fontFamily: "TrophyIcon")),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.nomeCampeonato}",
                          textAlign: TextAlign.start,
                          style: textStyle,
                        ),
                        Text(
                          "${widget.nomeRodada}",
                          textAlign: TextAlign.start,
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 13,
              child: Row(
                mainAxisAlignment: mostrarCampeonato ? MainAxisAlignment.end : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Icon(Icons.calendar_month),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data,
                          textAlign: TextAlign.start,
                          style: textStyle,
                        ),
                        Text(
                          widget.horario,
                          textAlign: TextAlign.start,
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (!mostrarCampeonato)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_month),
                const SizedBox(width: 10),
                Text(
                  widget.data,
                  textAlign: TextAlign.start,
                  style: textStyle,
                ),
                const SizedBox(width: 5),
                Text(
                  widget.horario,
                  textAlign: TextAlign.start,
                  style: textStyle,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
