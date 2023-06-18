// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    Key? key,
    this.controller,
    required this.child,
  }) : super(key: key);

  final ZoomDrawerController? controller;
  final Widget child;

  @override
  State<AppDrawer> createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ZoomDrawer(
      controller: widget.controller,
      menuBackgroundColor: theme.primaryColor,
      drawerShadowsBackgroundColor: theme.primaryColor,
      isRtl: true,
      style: DrawerStyle.defaultStyle,
      androidCloseOnBackTap: true,
      menuScreen: Material(
        child: Container(
          color: theme.primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              ...[
                {
                  "icon": Icons.favorite,
                  "text": "Doar para o desenvolvedor",
                  "link": "",
                },
                {
                  "icon": Icons.star,
                  "text": "Avaliar o aplicativo",
                  "link": "",
                },
                {
                  "icon": Icons.code,
                  "text": "Ver no GitHub",
                  "link": "https://github.com/joaopegoraro/meu-mengao",
                },
              ].map((item) {
                final icon = item['icon'] as IconData;
                final text = item['text'] as String;
                final link = item['link'] as String;
                return GestureDetector(
                  onTap: () {
                    final Uri url = Uri.parse(link);
                    launchUrl(url);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          color: theme.colorScheme.onPrimary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            text.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  color: theme.colorScheme.background,
                ),
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.dark_mode,
                      color: theme.colorScheme.primary,
                    ),
                    Switch(
                      value: true,
                      onChanged: (_) {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      mainScreen: widget.child,
    );
  }
}
