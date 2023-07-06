// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:launch_review/launch_review.dart';
import 'package:meu_mengao/ui/notifiers/dark_mode_notifier.dart';
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
                  "text": "Apoie o desenvolvedor",
                  "link": () {
                    final Uri url = Uri.parse("https://liberapay.com/joao_pegoraro/");
                    launchUrl(url);
                  },
                },
                {
                  "icon": Icons.star,
                  "text": "Avaliar o aplicativo",
                  "link": () {
                    LaunchReview.launch(androidAppId: "com.joaopegoraro.meu_mengao");
                  },
                },
                {
                  "icon": Icons.code,
                  "text": "Ver no GitHub",
                  "link": () {
                    final Uri url = Uri.parse("https://github.com/joaopegoraro/meu-mengao");
                    launchUrl(url);
                  },
                },
              ].map((item) {
                final icon = item['icon'] as IconData;
                final text = item['text'] as String;
                final action = item['link'] as VoidCallback;
                return GestureDetector(
                  onTap: action,
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
                    Consumer(builder: (_, ref, __) {
                      final darkModeNotifier = ref.watch(darkModeNotifierProvider);
                      return Switch(
                        value: darkModeNotifier.isDarkMode,
                        onChanged: darkModeNotifier.setDarkMode,
                      );
                    }),
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
