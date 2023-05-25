import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:meu_mengao/data/repositories/noticias_repository.dart';
import 'package:meu_mengao/ui/noticias/widgets/proxima_partida.dart';

import 'widgets/noticia_item.dart';

class TelaNoticias extends StatefulWidget {
  const TelaNoticias({super.key});

  @override
  State<TelaNoticias> createState() => _TelaNoticiasState();
}

class _TelaNoticiasState extends State<TelaNoticias> with AutomaticKeepAliveClientMixin<TelaNoticias> {
  final NoticiasRepository _noticiasRepository = NoticiasRepositoryImpl();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Expanded(
      child: FutureBuilder(
        future: _noticiasRepository.getNoticias(),
        builder: (context, snapshot) {
          final noticias = snapshot.data != null ? List.filled(10, snapshot.data!.first).whereNotNull().toList() : [];

          if (noticias.isEmpty || snapshot.hasError) return const Center(child: CircularProgressIndicator());

          return ListView.builder(
            itemCount: noticias.length + 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: ProximaPartida(),
                );
              }
              return NoticiaItem(noticia: noticias[index - 1]);
            },
          );
        },
      ),
    );
  }
}
