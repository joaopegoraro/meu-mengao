import 'package:flutter/material.dart';
import 'package:meu_mengao/ui/widgets/topbar.dart';

class TelaCalendario extends StatelessWidget {
  const TelaCalendario({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TopBar(titulo: "Calendário"),
        Placeholder(color: Colors.red),
      ],
    );
  }
}
