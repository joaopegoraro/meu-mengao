import 'package:flutter/material.dart';

class DataPartida extends StatefulWidget {
  const DataPartida({
    super.key,
    required this.data,
    this.nomeCampeonato,
    this.nomeRodada,
    required this.horario,
  });

  final String? data;
  final String? horario;
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
      color: colorScheme.onSurface,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (mostrarCampeonato) ...[
            Expanded(
              //flex: 17,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    const IconData(0xe800, fontFamily: "TrophyIcon"),
                    color: colorScheme.onSurface,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.nomeCampeonato}",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.visible,
                          style: textStyle,
                        ),
                        Text(
                          "${widget.nomeRodada}",
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.start,
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              //flex: 13,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: colorScheme.onSurface,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.data != null)
                          Text(
                            widget.data!,
                            textAlign: TextAlign.start,
                            style: textStyle,
                          ),
                        if (widget.horario != null)
                          Text(
                            widget.horario!,
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
          if (!mostrarCampeonato) ...[
            const Spacer(),
            Icon(
              Icons.calendar_month,
              color: colorScheme.onSurface,
            ),
            const SizedBox(width: 10),
            Text(
              "${widget.data} ${widget.horario}",
              style: textStyle,
            ),
            const Spacer(),
          ],
        ],
      ),
    );
  }
}
