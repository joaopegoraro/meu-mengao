// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:meu_mengao/data/models/partida.dart';
import 'package:meu_mengao/data/models/posicao.dart';

class Campeonato {
  Campeonato({
    required this.id,
    required this.nome,
    required this.edicao,
    this.mataMata = const [],
    this.pontosCorridos = const [],
  });

  final String id;
  final String nome;
  final String edicao;

  final List<Partida> mataMata;
  final List<Posicao> pontosCorridos;

  bool get isCorrupted => id.isEmpty || nome.isEmpty || edicao.isEmpty;

  Campeonato copyWith({
    String? id,
    String? nome,
    String? edicao,
    List<Partida>? mataMata,
    List<Posicao>? pontosCorridos,
  }) {
    return Campeonato(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      edicao: edicao ?? this.edicao,
      mataMata: mataMata ?? this.mataMata,
      pontosCorridos: pontosCorridos ?? this.pontosCorridos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'edicao': edicao,
      'mataMata': mataMata.map((x) => x.toMap()).toList(),
      'pontosCorridos': pontosCorridos.map((x) => x.toMap()).toList(),
    };
  }

  factory Campeonato.fromMap(Map<String, dynamic> map) {
    return Campeonato(
      id: map['id'] ?? "",
      nome: map['nome'] ?? "",
      edicao: map['edicao'] ?? "",
      mataMata: List<Partida>.from(
        (map['mataMata'] as List<int>).map<Partida>(
          (x) => Partida.fromMap(x as Map<String, dynamic>),
        ),
      ),
      pontosCorridos: List<Posicao>.from(
        (map['pontosCorridos'] as List<int>).map<Posicao>(
          (x) => Posicao.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Campeonato.fromJson(String source) => Campeonato.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Campeonato(id: $id, nome: $nome, edicao: $edicao, mataMata: $mataMata, pontosCorridos: $pontosCorridos)';
  }

  @override
  bool operator ==(covariant Campeonato other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        other.edicao == edicao &&
        listEquals(other.mataMata, mataMata) &&
        listEquals(other.pontosCorridos, pontosCorridos);
  }

  @override
  int get hashCode {
    return id.hashCode ^ nome.hashCode ^ edicao.hashCode ^ mataMata.hashCode ^ pontosCorridos.hashCode;
  }
}
