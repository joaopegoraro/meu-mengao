import 'package:flutter/material.dart';
import 'package:meu_mengao/data/repositories/partidas_repository.dart';
import 'package:meu_mengao/ui/noticias/widgets/data_partida.dart';
import 'package:meu_mengao/ui/noticias/widgets/placar.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 30),
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
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Card(
                    child: Column(
                      children: [
                        Placar(partida: partida),
                        DataPartida(
                          data: partida.readableDate ?? "",
                          campeonatoId: partida.campeonatoId,
                        ),
                      ],
                    ),
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
