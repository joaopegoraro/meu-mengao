import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_mengao/data/models/noticia.dart';
import 'package:meu_mengao/data/repositories/noticias_repository.dart';

class NoticiasNotifier extends ChangeNotifier {
  NoticiasNotifier(this._noticiasRepository);
  final NoticiasRepository _noticiasRepository;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Noticia> _noticias = [];
  List<Noticia> get noticias => _noticias;

  void listarNoticias() {
    _isLoading = true;
    notifyListeners();

    _noticiasRepository.getAll().then((lista) {
      _noticias = lista;
      notifyListeners();
    }).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
  }
}

final noticiasNotifierProvider = ChangeNotifierProvider<NoticiasNotifier>((ref) {
  final noticiasRepository = ref.watch(noticiasRepositoryProvider);
  return NoticiasNotifier(noticiasRepository);
});
