import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_mengao/data/repositories/partidas_repository.dart';

import '../../data/models/partida.dart';

class RodadasNotifier extends ChangeNotifier {
  RodadasNotifier(this._partidasRepository);
  final PartidasRepository _partidasRepository;

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

final rodadasNotifierProvider = ChangeNotifierProvider<RodadasNotifier>((ref) {
  final partidasRepository = ref.watch(partidasRepositoryProvider);
  return RodadasNotifier(partidasRepository);
});
