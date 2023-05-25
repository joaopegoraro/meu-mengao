import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/noticia.dart';
import 'package:meu_mengao/data/repositories/sites_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticiaItem extends StatefulWidget {
  const NoticiaItem({
    super.key,
    required this.noticia,
  });

  final Noticia noticia;

  @override
  State<NoticiaItem> createState() => _NoticiaItemState();
}

class _NoticiaItemState extends State<NoticiaItem> {
  final SitesRepository _sitesRepository = SitesRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      child: GestureDetector(
        onTap: () {
          final Uri url = Uri.parse(widget.noticia.link);
          launchUrl(url);
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.memory(
                base64Decode(widget.noticia.foto!),
                fit: BoxFit.fill,
                errorBuilder: (_, __, ___) {
                  return Image.asset(
                    "assets/images/maracana.jpg",
                    fit: BoxFit.fill,
                  );
                },
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: Colors.black.withOpacity(0.6),
                ),
                child: Text(
                  widget.noticia.titulo,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FutureBuilder(
                    future: _sitesRepository.getSiteWithId(widget.noticia.siteId),
                    builder: (context, snapshot) {
                      final site = snapshot.data;

                      if (site?.logo?.isNotEmpty != true || snapshot.hasError) {
                        return const SizedBox.shrink();
                      }

                      return Image.memory(
                        base64Decode(site?.logo ?? ""),
                        height: 25,
                        errorBuilder: (_, __, ___) {
                          return const SizedBox.shrink();
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
