import 'package:flutter/material.dart';
import 'package:meu_mengao/data/repositories/classificacao_repository.dart';
import 'package:meu_mengao/data/repositories/partidas_repository.dart';
import 'package:meu_mengao/ui/tabelas/widgets/tabela_classificacao.dart';
import 'package:meu_mengao/ui/tabelas/widgets/tabela_rodada.dart';

import '../../../data/models/campeonato.dart';

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
  final ClassificacaoRepository _classificacaoRepository = ClassificacaoRepository();
  final PartidasRepository _partidasRepository = PartidasRepository();

  @override
  Widget build(BuildContext context) {
    if (widget.campeonato?.id.isEmpty != false) {
      return const Placeholder(
        color: Colors.green,
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
              future: _classificacaoRepository.getWithCampeonatoId(widget.campeonato!.id),
              builder: (context, snapshot) {
                final classificacao = snapshot.data ?? [];
                if (classificacao.isEmpty) {
                  return const SizedBox.shrink();
                }
                return TabelaClassificacao(classificacao: classificacao);
              }),
          const SizedBox(height: 30),
          FutureBuilder(
              future: _partidasRepository.getRodadas(widget.campeonato!.id),
              builder: (context, snapshot) {
                final rodadas = snapshot.data ?? [];
                if (rodadas.isEmpty) {
                  return const Placeholder(
                    color: Colors.black,
                  );
                }

                return TabelaRodada(
                  partidas: rodadas,
                  indexInicial: widget.campeonato?.rodadaAtual ?? 0,
                );
              }),
        ],
      ),
    );
  }
}
