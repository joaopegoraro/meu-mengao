import 'package:flutter/material.dart';
import 'package:meu_mengao/ui/noticias/widgets/proxima_partida.dart';
import 'package:meu_mengao/ui/providers/noticias_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/noticia_item.dart';

class TelaNoticias extends StatefulWidget {
  const TelaNoticias({super.key});

  @override
  State<TelaNoticias> createState() => _TelaNoticiasState();
}

class _TelaNoticiasState extends State<TelaNoticias> with AutomaticKeepAliveClientMixin<TelaNoticias> {
  @override
  void initState() {
    super.initState();
    context.read<NoticiasProvider>().listarNoticias();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<NoticiasProvider>(
      builder: (context, provider, _) {
        final noticias = provider.noticias;
        final isLoading = provider.isLoading;

        if (isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

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
    );
  }
}
