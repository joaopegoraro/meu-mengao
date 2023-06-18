import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_mengao/data/models/partida.dart';
import 'package:meu_mengao/data/repositories/partidas_repository.dart';

class CalendarioNotifier extends ChangeNotifier {
  CalendarioNotifier(this._partidasRepository);
  final PartidasRepository _partidasRepository;

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

final calendarioNotifierProvider = ChangeNotifierProvider<CalendarioNotifier>((ref) {
  final partidasRepository = ref.watch(partidasRepositoryProvider);
  return CalendarioNotifier(partidasRepository);
});
