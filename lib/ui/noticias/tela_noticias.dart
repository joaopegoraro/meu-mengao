import 'package:flutter/material.dart';
import 'package:meu_mengao/ui/noticias/widgets/topbar.dart';

class TelaNoticias extends StatelessWidget {
  const TelaNoticias({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TopBar(),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
          ),
        ],
      ),
    );
  }
}
