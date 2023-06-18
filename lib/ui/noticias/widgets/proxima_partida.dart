import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_mengao/ui/notifiers/proxima_partida_notifier.dart';

import '../../widgets/partida/partida_item.dart';

class ProximaPartida extends ConsumerStatefulWidget {
  const ProximaPartida({super.key});

  @override
  ConsumerState<ProximaPartida> createState() => _ProximaPartidaState();
}

class _ProximaPartidaState extends ConsumerState<ProximaPartida> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(proximaPartidaNotifierProvider).listarProximaPartida();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final notifier = ref.watch(proximaPartidaNotifierProvider);
    final proximaPartida = notifier.proximaPartida;
    final isLoading = notifier.isLoading;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
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
              child: Builder(builder: (_) {
                if (!isLoading && proximaPartida == null) {
                  return const Padding(
                    padding: EdgeInsets.all(50.0),
                    child: Center(
                      child: Text(
                        "Não foi encontrada nenhuma partida.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                return PartidaItem(
                  partida: proximaPartida,
                  mostrarCampeonato: true,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
