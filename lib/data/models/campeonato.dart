// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:meu_mengao/data/models/partida.dart';
import 'package:meu_mengao/data/models/time.dart';

class Campeonato {
  Campeonato({
    required this.id,
    required this.nome,
    this.mataMata = const [],
    this.classificacao = const [],
  });

  final String id;
  final String nome;

  final List<Partida> mataMata;
  final List<Time> classificacao;

  bool get isCorrupted => id.isEmpty || nome.isEmpty;
  bool get hasData => mataMata.isNotEmpty || classificacao.isNotEmpty;

  Campeonato copyWith({
    String? id,
    String? nome,
    String? edicao,
    List<Partida>? mataMata,
    List<Time>? classificacao,
  }) {
    return Campeonato(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      mataMata: mataMata ?? this.mataMata,
      classificacao: classificacao ?? this.classificacao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'mataMata': mataMata.map((x) => x.toMap()).toList(),
      'pontosCorridos': classificacao.map((x) => x.toMap()).toList(),
    };
  }

  factory Campeonato.fromMap(Map<String, dynamic> map) {
    return Campeonato(
      id: map['id'] ?? "",
      nome: map['nome'] ?? "",
    );
  }

  @override
  String toString() {
    return 'Campeonato(id: $id, nome: $nome, mataMata: $mataMata, pontosCorridos: $classificacao)';
  }

  @override
  bool operator ==(covariant Campeonato other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        listEquals(other.mataMata, mataMata) &&
        listEquals(other.classificacao, classificacao);
  }

  @override
  int get hashCode {
    return id.hashCode ^ nome.hashCode ^ mataMata.hashCode ^ classificacao.hashCode;
  }
}
