import 'package:flutter/material.dart';
import 'package:meu_mengao/ui/providers/classificacao_provider.dart';
import 'package:meu_mengao/ui/tabelas/widgets/tabela_classificacao.dart';
import 'package:meu_mengao/ui/tabelas/widgets/tabela_rodada.dart';
import 'package:provider/provider.dart';

import '../../../data/models/campeonato.dart';
import '../../providers/rodadas_provider.dart';

class CampeonatoItem extends StatefulWidget {
  const CampeonatoItem({
    super.key,
    required this.campeonato,
  });

  final Campeonato? campeonato;

  @override
  State<CampeonatoItem> createState() => CampeonatoItemState();
}

class CampeonatoItemState extends State<CampeonatoItem> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final campeonatoId = widget.campeonato?.id;
      if (campeonatoId != null) {
        context.read<ClassificacaoProvider>().listarClassificacao(campeonatoId);
        context.read<RodadasProvider>().listarRodadas(campeonatoId);
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
      child: Consumer2<ClassificacaoProvider, RodadasProvider>(
        builder: (context, classificacaoProvider, rodadasProvider, _) {
          final classificacao = classificacaoProvider.classificacao;
          final isLoadingClassificacao = classificacaoProvider.isLoading;

          final rodadas = rodadasProvider.rodadas;
          final isLoadingRodadas = rodadasProvider.isLoading;

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
