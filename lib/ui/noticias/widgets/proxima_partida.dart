import 'package:flutter/material.dart';
import 'package:meu_mengao/ui/providers/proxima_partida_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/partida/partida_item.dart';

class ProximaPartida extends StatefulWidget {
  const ProximaPartida({super.key});

  @override
  State<ProximaPartida> createState() => _ProximaPartidaState();
}

class _ProximaPartidaState extends State<ProximaPartida> {
  @override
  void initState() {
    super.initState();
    context.read<ProximaPartidaProvider>().listarProximaPartida();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
              child: Consumer<ProximaPartidaProvider>(builder: (context, provider, _) {
                final proximaPartida = provider.proximaPartida;
                final isLoading = provider.isLoading;

                if (!isLoading && proximaPartida == null) {
                  return const Center(
                    child: Text("Não foi encontrada nenhuma partida."),
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
