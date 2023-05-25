import 'package:flutter/material.dart';
import 'package:meu_mengao/ui/app/widgets/app_bottom_nav.dart';
import 'package:meu_mengao/ui/noticias/tela_noticias.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _pageIndex = 0;
  late final PageController _pagerController;

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
      body: PageView(
        controller: _pagerController,
        //physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) => setState(() {
          _pageIndex = index;
        }),
        children: const [
          TelaNoticias(),
          Placeholder(color: Colors.red),
          Placeholder(color: Colors.blue),
          Placeholder(color: Colors.green),
        ],
      ),
    );
  }
}
