import 'package:flutter/material.dart';
import 'package:meu_mengao/ui/tabelas/widgets/tabela_classificacao.dart';
import 'package:meu_mengao/ui/tabelas/widgets/tabela_rodada.dart';

import '../../../data/api/api_service.dart';

class CampeonatoItem extends StatefulWidget {
  const CampeonatoItem({
    super.key,
    required this.campeonatoId,
  });

  final String? campeonatoId;

  @override
  State<CampeonatoItem> createState() => CampeonatoItemState();
}

class CampeonatoItemState extends State<CampeonatoItem> {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    if (widget.campeonatoId?.isEmpty != false) {
      return const Placeholder(
        color: Colors.green,
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
              future: _apiService.getClassificacao(widget.campeonatoId!),
              builder: (context, snapshot) {
                final classificacao = snapshot.data ?? [];
                if (classificacao.isEmpty) {
                  return const SizedBox.shrink();
                }
                return TabelaClassificacao(classificacao: classificacao);
              }),
          const SizedBox(height: 30),
          FutureBuilder(
              future: _apiService.getRodadas(widget.campeonatoId!),
              builder: (context, snapshot) {
                final rodadas = snapshot.data ?? [];
                if (rodadas.isEmpty) {
                  return const Placeholder(
                    color: Colors.black,
                  );
                }

                return TabelaRodada(partidas: rodadas);
              }),
        ],
      ),
    );
  }
}
