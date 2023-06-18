import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_mengao/data/models/posicao.dart';
import 'package:meu_mengao/data/repositories/classificacao_repository.dart';

class ClassificacaoNotifier extends ChangeNotifier {
  ClassificacaoNotifier(this._classificacaoRepository);
  final ClassificacaoRepository _classificacaoRepository;

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

final classificacaoNotifierProvider = ChangeNotifierProvider<ClassificacaoNotifier>((ref) {
  final classificacaoRepository = ref.watch(classificacaoRepositoryProvider);
  return ClassificacaoNotifier(classificacaoRepository);
});
