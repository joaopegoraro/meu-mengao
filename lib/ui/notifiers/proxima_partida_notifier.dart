import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_mengao/data/repositories/partidas_repository.dart';

import '../../data/models/partida.dart';

class ProximaPartidaNotifier extends ChangeNotifier {
  ProximaPartidaNotifier(this._partidasRepository);
  final PartidasRepository _partidasRepository;

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

final proximaPartidaNotifierProvider = ChangeNotifierProvider<ProximaPartidaNotifier>((ref) {
  final partidasRepository = ref.watch(partidasRepositoryProvider);
  return ProximaPartidaNotifier(partidasRepository);
});
