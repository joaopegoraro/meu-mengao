import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/campeonato.dart';
import 'package:meu_mengao/data/repositories/campeonatos_repository.dart';

class CampeonatosProvider extends ChangeNotifier {
  final _campeonatosRepository = CampeonatosRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Campeonato> _campeonatos = [];
  List<Campeonato> get campeonatos => _campeonatos;

  Campeonato? _campeonatoSelecionado;
  Campeonato? get campeonatoSelecionado => _campeonatoSelecionado;

  void setCampeonatoSelecionado(String? campeonatoId) {
    _campeonatoSelecionado = campeonatos.firstWhere((campeonato) {
      return campeonato.id == campeonatoId;
    });
    notifyListeners();
  }

  void listarCampeonatos() {
    _isLoading = true;
    notifyListeners();

    _campeonatosRepository.getAll().then((lista) {
      _campeonatos = lista;
      notifyListeners();
    }).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
  }
}
