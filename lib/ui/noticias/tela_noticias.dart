import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_mengao/ui/noticias/widgets/proxima_partida.dart';
import 'package:meu_mengao/ui/notifiers/noticias_notifier.dart';
import 'package:shimmer/shimmer.dart';

import 'widgets/noticia_item.dart';

class TelaNoticias extends ConsumerStatefulWidget {
  const TelaNoticias({super.key});

  @override
  ConsumerState<TelaNoticias> createState() => _TelaNoticiasState();
}

class _TelaNoticiasState extends ConsumerState<TelaNoticias> with AutomaticKeepAliveClientMixin<TelaNoticias> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(noticiasNotifierProvider).listarNoticias();
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final notifier = ref.watch(noticiasNotifierProvider);
    final noticias = notifier.noticias;
    final isLoading = notifier.isLoading;

    return ListView.builder(
      itemCount: isLoading
          ? 10
          : noticias.isEmpty
              ? 2
              : noticias.length + 1,
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

        if (noticias.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(50.0),
            child: Center(
              child: Text(
                "Não foi encontrada nenhuma notícia.",
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return NoticiaItem(noticia: noticias[index - 1]);
      },
    );
  }
}
