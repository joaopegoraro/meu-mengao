import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.clicarBotao,
  });

  static const int _noticiasIndex = 0;
  static const int _jogosIndex = 1;
  static const int _tabelasIndex = 2;
  static const int _maisIndex = 3;

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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  minWidth: 40,
                  onPressed: () => clicarBotao(_noticiasIndex),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: buttonColor(_noticiasIndex),
                      ),
                      Text(
                        "Notícias",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: buttonColor(_noticiasIndex),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  minWidth: 40,
                  onPressed: () => clicarBotao(_jogosIndex),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: buttonColor(_jogosIndex),
                      ),
                      Text(
                        "Jogos",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: buttonColor(_jogosIndex),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  minWidth: 40,
                  onPressed: () => clicarBotao(_tabelasIndex),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.table_chart_sharp,
                        color: buttonColor(_tabelasIndex),
                      ),
                      Text(
                        "Tabelas",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: buttonColor(_tabelasIndex),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  minWidth: 40,
                  onPressed: () => clicarBotao(_maisIndex),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.menu,
                        color: buttonColor(_maisIndex),
                      ),
                      Text(
                        "Mais",
                        style: theme.textTheme.bodySmall?.copyWith(
                        color: buttonColor(_maisIndex),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
