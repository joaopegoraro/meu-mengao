import 'package:flutter/material.dart';
import 'package:meu_mengao/data/models/posicao.dart';
import 'package:meu_mengao/data/repositories/classificacao_repository.dart';

class ClassificacaoProvider extends ChangeNotifier {
  final _classificacaoRepository = ClassificacaoRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Posicao> _classificacao = [];
  List<Posicao> get classificacao => _classificacao;

  void listarClassificacao(String campeonatoId) {
    _isLoading = true;
    _classificacao = [];
    notifyListeners();

    _classificacaoRepository.getWithCampeonatoId(campeonatoId).then((lista) {
      _classificacao = lista;
      notifyListeners();
    }).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
  }
}
