import 'package:flutter/material.dart';
import 'package:meu_mengao/data/repositories/campeonato_repository.dart';
import 'package:meu_mengao/ui/tabelas/widgets/tabela_classificacao.dart';
import 'package:meu_mengao/ui/tabelas/widgets/tabela_mata_mata.dart';

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
  final CampeonatoRepository _campeonatoRepository = CampeonatoRepositoryImpl();
  @override
  Widget build(BuildContext context) {
    if (widget.campeonatoId?.isEmpty != false) {
      return const Placeholder(
        color: Colors.green,
      );
    }

    return FutureBuilder(
      future: _campeonatoRepository.getCampeonatoWithId(widget.campeonatoId!),
      builder: (context, snapshot) {
        final campeonato = snapshot.data;

        if (campeonato?.hasData != true) {
          return const Placeholder(
            color: Colors.red,
          );
        }

        return Column(
          children: [
            if (campeonato!.classificacao.isNotEmpty) TabelaClassificacao(times: campeonato.classificacao),
            if (campeonato.mataMata.isNotEmpty) const TabelaMataMata(),
          ],
        );
      },
    );
  }
}
