import 'package:flutter/material.dart';
import 'package:meu_mengao/data/repositories/partidas_repository.dart';
import 'package:meu_mengao/ui/noticias/widgets/escudo_time.dart';

class ProximaPartida extends StatefulWidget {
  const ProximaPartida({super.key});

  @override
  State<ProximaPartida> createState() => _ProximaPartidaState();
}

class _ProximaPartidaState extends State<ProximaPartida> {
  final PartidasRepository _partidasRepository = PartidasRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: FutureBuilder(
          future: _partidasRepository.getProximaPartida(),
          builder: (context, snapshot) {
            final partida = snapshot.data;

            if (partida == null) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Próxima Partida",
                  textAlign: TextAlign.start,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colorScheme.onBackground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          EscudoTime(escudo: partida.timeCasa.escudo),
                          const Spacer(),
                          Text(
                            partida.timeCasa.nome,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onBackground,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          if (partida.golsCasa == null || partida.golsCasa! < 0)
                            Text(
                              "vs",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onBackground,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          else ...[
                            Text(
                              "${partida.golsCasa}",
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onBackground,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '-',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onBackground,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${partida.golsFora}",
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onBackground,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                          const Spacer(),
                          Text(
                            partida.timeFora.nome,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onBackground,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          EscudoTime(escudo: partida.timeFora.escudo),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
