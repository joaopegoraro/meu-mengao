import 'package:flutter/material.dart';
import 'package:meu_mengao/data/repositories/partidas_repository.dart';

import '../../data/models/partida.dart';

class RodadasProvider extends ChangeNotifier {
  final _partidasRepository = PartidasRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Partida> _rodadas = [];
  List<Partida> get rodadas => _rodadas;

  void listarRodadas(String campeonatoId) {
    _isLoading = true;
    _rodadas = [];
    notifyListeners();

    _partidasRepository.getRodadas(campeonatoId).then((lista) {
      _rodadas = lista;
      notifyListeners();
    }).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
  }
}
