import 'dart:convert';

import 'package:flutter/material.dart';

class EscudoTime extends StatelessWidget {
  const EscudoTime({
    super.key,
    this.escudo,
    this.height = 40,
  });

  final String? escudo;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      base64Decode(escudo ?? ""),
      height: height,
      errorBuilder: (_, __, ___) {
        return Image.asset(
          escudo == "FLAMENGO" ? "assets/icons/flamengo.png" : "assets/icons/escudo-generico.png",
          height: height,
        );
      },
    );
  }
}
