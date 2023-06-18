import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.titulo,
    required this.toggleDrawer,
  });

  final String titulo;
  final VoidCallback toggleDrawer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 30, top: 60),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titulo,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: toggleDrawer,
              child: Icon(
                Icons.menu,
                color: colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
