import 'package:flutter/material.dart';
import 'package:meu_mengao/data/repositories/noticias_repository.dart';
import 'package:meu_mengao/ui/noticias/widgets/noticia.dart';
import 'package:meu_mengao/ui/noticias/widgets/proxima_partida.dart';

class ListaNoticias extends StatefulWidget {
  const ListaNoticias({super.key});

  @override
  State<ListaNoticias> createState() => _ListaNoticiasState();
}

class _ListaNoticiasState extends State<ListaNoticias> {
  final NoticiasRepository _noticiasRepository = NoticiasRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _noticiasRepository.getNoticias(),
      builder: (context, snapshot) {
        final noticias = snapshot.data ?? [];

        if (noticias.isEmpty || snapshot.hasError) return const Placeholder();

        return ListView.builder(
          itemCount: noticias.length + 1,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const ProximaPartida();
            }
            return NoticiaItem(noticia: noticias[index - 1]);
          },
        );
      },
    );
  }
}
