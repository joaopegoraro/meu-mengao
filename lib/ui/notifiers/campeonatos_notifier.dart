import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_mengao/data/models/campeonato.dart';
import 'package:meu_mengao/data/repositories/campeonatos_repository.dart';

class CampeonatosNotifier extends ChangeNotifier {
  CampeonatosNotifier(this._campeonatosRepository);
  final CampeonatosRepository _campeonatosRepository;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Campeonato> _campeonatos = [];
  List<Campeonato> get campeonatos => _campeonatos;

  Campeonato? _campeonatoSelecionado;
  Campeonato? get campeonatoSelecionado => _campeonatoSelecionado;

  void setCampeonatoSelecionado(String? campeonatoId) {
    if (campeonatoId == null) {
      _campeonatoSelecionado = null;
      notifyListeners();
    } else {
      _campeonatosRepository.get(campeonatoId).then((campeonato) {
        _campeonatoSelecionado = campeonato;
        notifyListeners();
      });
    }
  }

  Future<void> listarCampeonatos() async {
    _isLoading = true;
    notifyListeners();

    await _campeonatosRepository.getAll().then((lista) {
      _campeonatos = lista;
      notifyListeners();
    }).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
  }
}

final campeonatosNotifierProvider = ChangeNotifierProvider<CampeonatosNotifier>((ref) {
  final campeonatosRepository = ref.watch(campeonatosRepositoryProvider);
  return CampeonatosNotifier(campeonatosRepository);
});
