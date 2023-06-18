import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:meu_mengao/data/models/campeonato.dart';
import 'package:meu_mengao/data/models/noticia.dart';
import 'package:meu_mengao/data/models/partida.dart';
import 'package:meu_mengao/data/models/posicao.dart';
import 'package:meu_mengao/data/repositories/auth_repository.dart';

abstract class ApiService {
  Future<List<Noticia>?> getNoticias();

  Future<Partida?> getProximaPartida();

  Future<List<Partida>?> getResultados();

  Future<List<Partida>?> getCalendario();

  Future<List<Campeonato>?> getCampeonatos();

  Future<List<Posicao>?> getClassificacao(String campeonatoId);

  Future<List<Partida>?> getRodadas(String campeonatoId);
}

class ApiServiceImpl extends ApiService {
  ApiServiceImpl(this._authRepository);

  final AuthRepository _authRepository;

  static const _baseUrl = "http://192.168.3.9:3000/";

  @override
  Future<List<Noticia>?> getNoticias() async {
    return _getData("noticias", (response) {
      final List noticias = jsonDecode(response.body);
      return noticias.map((noticia) => Noticia.fromMap(noticia)).toList();
    });
  }

  @override
  Future<Partida?> getProximaPartida() async {
    return _getData("partidas/proxima", (response) {
      return Partida.fromJson(response.body);
    });
  }

  @override
  Future<List<Partida>?> getResultados() async {
    return _getData("partidas/resultados", (response) {
      final List jsonList = jsonDecode(response.body);
      return jsonList.map((e) => Partida.fromMap(e)).toList();
    });
  }

  @override
  Future<List<Partida>?> getCalendario() async {
    return _getData("partidas/calendario", (response) {
      final List jsonList = jsonDecode(response.body);
      return jsonList.map((e) => Partida.fromMap(e)).toList();
    });
  }

  @override
  Future<List<Campeonato>?> getCampeonatos() async {
    return _getData("campeonatos", (response) {
      final List jsonList = jsonDecode(response.body);
      return jsonList.map((e) => Campeonato.fromMap(e)).toList();
    });
  }

  @override
  Future<List<Posicao>?> getClassificacao(String campeonatoId) async {
    return _getData("posicao/campeonato/$campeonatoId", (response) {
      final List jsonList = jsonDecode(response.body);
      return jsonList.map((e) => Posicao.fromMap(e)).toList();
    });
  }

  @override
  Future<List<Partida>?> getRodadas(String campeonatoId) async {
    return _getData("partidas/campeonato/$campeonatoId", (response) {
      final List jsonList = jsonDecode(response.body);
      return jsonList.map((e) => Partida.fromMap(e)).toList();
    });
  }

  Future<T?> _getData<T>(
    String endpoint,
    T Function(Response response) parseResponse,
  ) async {
    try {
      final url = Uri.parse(_baseUrl + endpoint);
      final token = await _authRepository.getToken();
      final response = await http.get(url, headers: {'Authorization': 'Bearer $token'});
      return response.statusCode == 200 ? parseResponse(response) : null;
    } catch (e) {
      if (kDebugMode) print(e);
      return null;
    }
  }
}

final apiServiceProvider = Provider<ApiService>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return ApiServiceImpl(authRepository);
});
