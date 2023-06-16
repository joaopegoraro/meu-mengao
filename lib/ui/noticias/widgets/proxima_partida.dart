import 'package:flutter/material.dart';

import '../../../data/api/api_service.dart';
import '../../widgets/partida/partida_item.dart';

class ProximaPartida extends StatefulWidget {
  const ProximaPartida({super.key});

  @override
  State<ProximaPartida> createState() => _ProximaPartidaState();
}

class _ProximaPartidaState extends State<ProximaPartida> {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder(
          future: _apiService.getProximaPartida(),
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
                  child: PartidaItem(
                    partida: partida,
                    mostrarCampeonato: true,
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
