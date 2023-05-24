import 'package:flutter/material.dart';
import 'package:meu_mengao/data/repositories/campeonato_repository.dart';

class DataPartida extends StatefulWidget {
  const DataPartida({
    super.key,
    required this.data,
    this.campeonatoId,
  });

  final String data;
  final String? campeonatoId;

  @override
  State<DataPartida> createState() => _DataPartidaState();
}

class _DataPartidaState extends State<DataPartida> {
  final CampeonatoRepository _campeonatoRepository = CampeonatoRepositoryImpl();

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
      child: FutureBuilder(
        future:
            widget.campeonatoId == null ? null : _campeonatoRepository.getNomeCampeonatoWithId(widget.campeonatoId!),
        builder: (context, snapshot) {
          final nomeCampeonato = snapshot.data;
          final nomeCampeonatoValido = nomeCampeonato != null && nomeCampeonato.isNotEmpty && !snapshot.hasError;

          return Row(
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  Text(" ${widget.data}", style: textStyle),
                ],
              ),
              if (nomeCampeonatoValido) ...[
                const Spacer(),
                Row(
                  children: [
                    const Icon(IconData(0xe800, fontFamily: "TrophyIcon")),
                    Text(" $nomeCampeonato", style: textStyle),
                  ],
                ),
              ]
            ],
          );
        },
      ),
    );
  }
}
