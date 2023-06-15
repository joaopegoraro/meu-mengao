import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meu_mengao/data/models/noticia.dart';
import 'package:meu_mengao/data/models/partida.dart';
import 'package:meu_mengao/data/repositories/auth_repository.dart';

class ApiService {
  final _authRepository = AuthRepository();
  static const _baseUrl = "http://192.168.3.9:3000/";

  Future<List<Noticia>?> getNoticias() async {
    try {
      final url = Uri.parse("${_baseUrl}noticias");
      final token = await _authRepository.getToken();
      print("URL: $url");
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        print("PEGANDO NOTICIAS");
        final List jsonList = jsonDecode(response.body);
        List<Noticia> noticias = jsonList.map((noticia) => Noticia.fromMap(noticia)).toList();
        print(noticias);
        return noticias;
      }

      print("ERRO: ${response.statusCode}");
      return null;
    } catch (e) {
      print("ERRO: $e");

      return null;
    }
  }

  Future<Partida?> getProximaPartida() async {
    try {
      final url = Uri.parse("${_baseUrl}partidas/proxima");
      final token = await _authRepository.getToken();
      print("URL: $url");
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        print("PEGANDO PROXIMA PARTIDA");
        final Partida partida = Partida.fromJson(response.body);
        print(partida);
        return partida;
      }

      print("ERRO: ${response.statusCode}");
      return null;
    } catch (e) {
      print("ERRO: $e");

      return null;
    }
  }
}
