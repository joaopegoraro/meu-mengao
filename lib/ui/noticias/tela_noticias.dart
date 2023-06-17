import 'package:flutter/material.dart';
import 'package:meu_mengao/ui/noticias/widgets/proxima_partida.dart';
import 'package:meu_mengao/ui/providers/noticias_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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

        return Column(
          children: [
            ListView.builder(
              itemCount: isLoading ? 10 : noticias.length + 1,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: ProximaPartida(),
                  );
                }

                if (isLoading) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                      ),
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(20),
                      child: Container(
                        height: 200.0,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                if (noticias.isNotEmpty) {
                  return NoticiaItem(noticia: noticias[index - 1]);
                }

                return const SizedBox.shrink();
              },
            ),
            if (noticias.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Text("Não foi encontrada nenhuma notícia."),
                ),
              )
          ],
        );
      },
    );
  }
}
