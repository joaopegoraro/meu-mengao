import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_mengao/ui/notifiers/classificacao_notifier.dart';
import 'package:meu_mengao/ui/tabelas/widgets/tabela_classificacao.dart';
import 'package:meu_mengao/ui/tabelas/widgets/tabela_rodada.dart';

import '../../../data/models/campeonato.dart';
import '../../notifiers/rodadas_notifier.dart';

class CampeonatoItem extends ConsumerStatefulWidget {
  const CampeonatoItem({
    super.key,
    required this.campeonato,
  });

  final Campeonato? campeonato;

  @override
  ConsumerState<CampeonatoItem> createState() => CampeonatoItemState();
}

class CampeonatoItemState extends ConsumerState<CampeonatoItem> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final campeonatoId = widget.campeonato?.id;
      if (campeonatoId != null) {
        ref.read(classificacaoNotifierProvider).listarClassificacao(campeonatoId);
        ref.read(rodadasNotifierProvider).listarRodadas(campeonatoId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.campeonato?.id.isEmpty != false) {
      return const Center(
        child: Text("Não foi encontrada nenhuma tabela para esse campeonato"),
      );
    }

    return SingleChildScrollView(
      child: Builder(
        builder: (context) {
          final classificacaoNotifier = ref.watch(classificacaoNotifierProvider);
          final classificacao = classificacaoNotifier.classificacao;
          final isLoadingClassificacao = classificacaoNotifier.isLoading;

          final rodadasNotifier = ref.watch(rodadasNotifierProvider);
          final rodadas = rodadasNotifier.rodadas;
          final isLoadingRodadas = rodadasNotifier.isLoading;

          if (!isLoadingRodadas && !isLoadingClassificacao && classificacao.isEmpty && rodadas.isEmpty) {
            return const Center(
              child: Text("Não foi encontrada nenhuma tabela para esse campeonato"),
            );
          }

          return Column(
            children: [
              if (classificacao.isNotEmpty) ...[
                TabelaClassificacao(
                  classificacao: classificacao,
                  isLoading: isLoadingClassificacao,
                ),
                const SizedBox(height: 30),
              ],
              if (rodadas.isNotEmpty)
                TabelaRodada(
                  partidas: rodadas,
                  indexInicial: widget.campeonato?.rodadaAtual ?? 0,
                  isLoading: isLoadingRodadas,
                ),
            ],
          );
        },
      ),
    );
  }
}
