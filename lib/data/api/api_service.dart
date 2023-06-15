import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meu_mengao/data/models/campeonato.dart';
import 'package:meu_mengao/data/models/noticia.dart';
import 'package:meu_mengao/data/models/partida.dart';
import 'package:meu_mengao/data/models/posicao.dart';
import 'package:meu_mengao/data/repositories/auth_repository.dart';

class ApiService {
  final _authRepository = AuthRepository();
  static const _baseUrl = "http://192.168.3.9:3000/";

  Future<List<Noticia>?> getNoticias() async {
    try {
      final url = Uri.parse("${_baseUrl}noticias");
      final token = await _authRepository.getToken();
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final List jsonList = jsonDecode(response.body);
        List<Noticia> noticias = jsonList.map((noticia) => Noticia.fromMap(noticia)).toList();
        return noticias;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Partida?> getProximaPartida() async {
    try {
      final url = Uri.parse("${_baseUrl}partidas/proxima");
      final token = await _authRepository.getToken();
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final Partida partida = Partida.fromJson(response.body);
        return partida;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Partida>?> getResultados() async {
    try {
      final url = Uri.parse("${_baseUrl}partidas/resultados");
      final token = await _authRepository.getToken();
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final List jsonList = jsonDecode(response.body);
        final List<Partida> partidas = jsonList.map((e) => Partida.fromMap(e)).toList();
        return partidas;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Partida>?> getCalendario() async {
    try {
      final url = Uri.parse("${_baseUrl}partidas/calendario");
      final token = await _authRepository.getToken();
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final List jsonList = jsonDecode(response.body);
        final List<Partida> partidas = jsonList.map((e) => Partida.fromMap(e)).toList();
        return partidas;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Campeonato>?> getCampeonatos() async {
    try {
      final url = Uri.parse("${_baseUrl}campeonatos");
      final token = await _authRepository.getToken();
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final List jsonList = jsonDecode(response.body);
        final List<Campeonato> campeonatos = jsonList.map((e) => Campeonato.fromMap(e)).toList();
        return campeonatos;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Posicao>?> getClassificacao(String campeonatoId) async {
    try {
      final url = Uri.parse("${_baseUrl}posicao/campeonato/$campeonatoId");
      final token = await _authRepository.getToken();
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final List jsonList = jsonDecode(response.body);
        final List<Posicao> classificacao = jsonList.map((e) => Posicao.fromMap(e)).toList();
        return classificacao;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Partida>?> getRodadas(String campeonatoId) async {
    try {
      final url = Uri.parse("${_baseUrl}partidas/campeonato/$campeonatoId");
      final token = await _authRepository.getToken();
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final List jsonList = jsonDecode(response.body);
        final List<Partida> rodadas = jsonList.map((e) => Partida.fromMap(e)).toList();
        return rodadas;
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
