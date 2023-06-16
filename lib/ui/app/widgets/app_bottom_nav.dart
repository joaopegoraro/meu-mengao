import 'package:flutter/material.dart';
import 'package:meu_mengao/ui/app/widgets/bottom_nav_button.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.clicarBotao,
  });

  static const int _noticiasIndex = 0;
  static const int _calendarioIndex = 1;
  static const int _resultadosIndex = 2;
  static const int _tabelasIndex = 3;

  final int currentIndex;
  final void Function(int) clicarBotao;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    buttonColor(int index) {
      return currentIndex == index ? colorScheme.primary : colorScheme.onBackground;
    }

    return BottomAppBar(
      elevation: 20,
      color: colorScheme.background,
      surfaceTintColor: colorScheme.background,
      child: SizedBox(
        height: 60,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(2, (row) {
              final firstRow = row == 0;
              final buttons = firstRow ? [_noticiasIndex, _calendarioIndex] : [_resultadosIndex, _tabelasIndex];

              return Row(
                mainAxisAlignment: firstRow ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: buttons.map((buttonIndex) {
                  return BottomNavButton(
                    onPressed: () => clicarBotao(buttonIndex),
                    iconData: _getButtonIcon(buttonIndex),
                    color: buttonColor(buttonIndex),
                    text: _getButtonText(buttonIndex),
                  );
                }).toList(),
              );
            })),
      ),
    );
  }

  String _getButtonText(int buttonIndex) {
    switch (buttonIndex) {
      case _noticiasIndex:
        return "Notícias";
      case _calendarioIndex:
        return "Calendário";
      case _resultadosIndex:
        return "Resultados";
      default:
        return "Tabelas";
    }
  }

  IconData _getButtonIcon(int buttonIndex) {
    switch (buttonIndex) {
      case _noticiasIndex:
        return Icons.newspaper;
      case _calendarioIndex:
        return Icons.calendar_month;
      case _resultadosIndex:
        return Icons.sports_soccer;
      default:
        return Icons.table_chart_sharp;
    }
  }
}
