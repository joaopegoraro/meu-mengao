import 'package:flutter/material.dart';
import 'package:meu_mengao/ui/app/widgets/app_bottom_nav.dart';
import 'package:meu_mengao/ui/noticias/tela_noticias.dart';
import 'package:meu_mengao/ui/providers/calendario_provider.dart';
import 'package:meu_mengao/ui/providers/campeonatos_provider.dart';
import 'package:meu_mengao/ui/providers/classificacao_provider.dart';
import 'package:meu_mengao/ui/providers/noticias_provider.dart';
import 'package:meu_mengao/ui/providers/proxima_partida_provider.dart';
import 'package:meu_mengao/ui/providers/resultados_provider.dart';
import 'package:meu_mengao/ui/providers/rodadas_provider.dart';
import 'package:meu_mengao/ui/widgets/topbar.dart';
import 'package:provider/provider.dart';

import '../../calendario/tela_calendario.dart';
import '../../resultados/tela_resultados.dart';
import '../../tabelas/tela_tabelas.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _pageIndex = 0;
  late final PageController _pagerController;

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

    _pagerController = PageController(
      initialPage: _pageIndex,
      keepPage: true,
    );
  }

  @override
  void dispose() {
    _pagerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: TopBar(titulo: _titulo),
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
          _pagerController.jumpToPage(index);
          _pageIndex = index;
        }),
      ),
      body: SafeArea(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<NoticiasProvider>(create: (_) => NoticiasProvider()),
            ChangeNotifierProvider<ProximaPartidaProvider>(create: (_) => ProximaPartidaProvider()),
            ChangeNotifierProvider<ResultadosProvider>(create: (_) => ResultadosProvider()),
            ChangeNotifierProvider<CalendarioProvider>(create: (_) => CalendarioProvider()),
            ChangeNotifierProvider<CampeonatosProvider>(create: (_) => CampeonatosProvider()),
            ChangeNotifierProvider<ClassificacaoProvider>(create: (_) => ClassificacaoProvider()),
            ChangeNotifierProvider<RodadasProvider>(create: (_) => RodadasProvider()),
          ],
          child: PageView(
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
          ),
        ),
      ),
    );
  }
}
