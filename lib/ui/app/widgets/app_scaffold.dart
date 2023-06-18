import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:meu_mengao/ui/app/widgets/app_bottom_nav.dart';
import 'package:meu_mengao/ui/app/widgets/app_drawer.dart';
import 'package:meu_mengao/ui/noticias/tela_noticias.dart';
import 'package:meu_mengao/ui/notifiers/auth_notifier.dart';
import 'package:meu_mengao/ui/widgets/topbar.dart';

import '../../calendario/tela_calendario.dart';
import '../../resultados/tela_resultados.dart';
import '../../tabelas/tela_tabelas.dart';

class AppScaffold extends ConsumerStatefulWidget {
  const AppScaffold({super.key});

  @override
  ConsumerState<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends ConsumerState<AppScaffold> {
  int _pageIndex = 0;
  late final PageController _pagerController;
  ZoomDrawerController? _zoomDrawerController;

  String get _titulo {
    switch (_pageIndex) {
      case 0:
        return "Notícias";
      case 1:
        return "Calendário";
      case 2:
        return "Resultados";
      default:
        return "Tabelas";
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authNotifierProvider).signIn();
    });

    _pagerController = PageController(
      initialPage: _pageIndex,
      keepPage: true,
    );
    _zoomDrawerController = ZoomDrawerController();
  }

  @override
  void dispose() {
    _pagerController.dispose();
    _zoomDrawerController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDrawer(
      controller: _zoomDrawerController,
      child: Scaffold(
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: TopBar(
            titulo: _titulo,
            toggleDrawer: () {
              _zoomDrawerController?.toggle?.call();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 1,
          shape: const CircleBorder(),
          child: Image.asset(
            "assets/images/flamengo.png",
            height: 30,
          ),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        bottomNavigationBar: AppBottomNav(
          currentIndex: _pageIndex,
          clicarBotao: (index) => setState(() {
            _pagerController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastEaseInToSlowEaseOut,
            );
            _pageIndex = index;
          }),
        ),
        body: SafeArea(
          child: Builder(builder: (_) {
            final authNotifier = ref.watch(authNotifierProvider);
            final isLoading = authNotifier.isLoading;
            final authToken = authNotifier.token;

            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (authToken == null || authToken.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(30.0),
                child: Center(
                  child: Text(
                    "Ocorreu um erro ao tentar se conectar ao servidor. Tente novamente mais tarde ou entre em contato com o desenvolvedor",
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            return PageView(
              controller: _pagerController,
              onPageChanged: (index) => setState(() {
                _pageIndex = index;
              }),
              children: const [
                TelaNoticias(),
                TelaCalendario(),
                TelaResultados(),
                TelaTabelas(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
