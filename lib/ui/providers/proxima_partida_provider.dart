import 'package:flutter/material.dart';
import 'package:meu_mengao/data/repositories/partidas_repository.dart';

import '../../data/models/partida.dart';

class ProximaPartidaProvider extends ChangeNotifier {
  final _partidasRepository = PartidasRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Partida? _proximaPartida;
  Partida? get proximaPartida => _proximaPartida;

  void listarProximaPartida() {
    _isLoading = true;
    notifyListeners();

    _partidasRepository.getProximaPartida().then((partida) {
      _proximaPartida = partida;
      notifyListeners();
    }).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
  }
}
