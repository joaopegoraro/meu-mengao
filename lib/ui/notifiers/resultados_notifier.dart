import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_mengao/data/models/partida.dart';
import 'package:meu_mengao/data/repositories/partidas_repository.dart';

class ResultadosNotifier extends ChangeNotifier {
  ResultadosNotifier(this._partidasRepository);
  final PartidasRepository _partidasRepository;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Partida> _resultados = [];
  List<Partida> get resultados => _resultados;

  void listarResultados() {
    _isLoading = true;
    notifyListeners();

    _partidasRepository.getResultados().then((partidas) {
      _resultados = partidas;
      notifyListeners();
    }).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
  }
}

final resultadosNotifierProvider = ChangeNotifierProvider<ResultadosNotifier>((ref) {
  final partidasRepository = ref.watch(partidasRepositoryProvider);
  return ResultadosNotifier(partidasRepository);
});
