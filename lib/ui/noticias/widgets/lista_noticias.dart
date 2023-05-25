import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:meu_mengao/data/repositories/noticias_repository.dart';
import 'package:meu_mengao/ui/noticias/widgets/noticia.dart';
import 'package:meu_mengao/ui/noticias/widgets/proxima_partida.dart';

class ListaNoticias extends StatefulWidget {
  const ListaNoticias({super.key});

  @override
  State<ListaNoticias> createState() => _ListaNoticiasState();
}

class _ListaNoticiasState extends State<ListaNoticias> with AutomaticKeepAliveClientMixin<ListaNoticias> {
  final NoticiasRepository _noticiasRepository = NoticiasRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: _noticiasRepository.getNoticias(),
      builder: (context, snapshot) {
        final noticias = List.filled(10, snapshot.data!.first).whereNotNull().toList();

        if (noticias.isEmpty || snapshot.hasError) return const Placeholder();

        return Expanded(
          child: ListView.builder(
            itemCount: noticias.length + 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const ProximaPartida();
              }
              return NoticiaItem(noticia: noticias[index - 1]);
            },
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
