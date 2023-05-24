import 'package:flutter/material.dart';

class DataPartida extends StatelessWidget {
  const DataPartida({
    super.key,
    required this.data,
  });

  final String data;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.background,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.calendar_month),
          Text(
            " $data",
            style: theme.textTheme.labelLarge?.copyWith(
              color: colorScheme.onBackground,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
