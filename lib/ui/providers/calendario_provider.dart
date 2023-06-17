import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/partida.dart';
import 'package:meu_mengao/data/repositories/partidas_repository.dart';

class CalendarioProvider extends ChangeNotifier {
  final _partidasRepository = PartidasRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Partida> _calendario = [];
  List<Partida> get calendario => _calendario;

  void listarCalendario() {
    _isLoading = true;
    notifyListeners();

    _partidasRepository.getCalendario().then((partidas) {
      _calendario = partidas;
      notifyListeners();
    }).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
  }
}
