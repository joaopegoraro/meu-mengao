// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Campeonato {
  Campeonato({
    required this.id,
    required this.nome,
    required this.ano,
    required this.logo,
  });

  final String id;
  final String nome;
  final String ano;
  final String logo;

  bool get isCorrupted => id.isEmpty || nome.isEmpty;

  Campeonato copyWith({
    String? id,
    String? nome,
    String? ano,
    String? logo,
  }) {
    return Campeonato(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      ano: ano ?? this.ano,
      logo: logo ?? this.logo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'ano': ano,
      'logo': logo,
    };
  }

  factory Campeonato.fromMap(Map<String, dynamic> map) {
    return Campeonato(
      id: map['id'] as String,
      nome: map['nome'] as String,
      ano: map['ano'] as String,
      logo: map['logo'] as String,
    );
  }

  @override
  String toString() {
    return 'Campeonato(id: $id, nome: $nome, ano: $ano, logo: $logo)';
  }

  @override
  bool operator ==(covariant Campeonato other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nome == nome && other.ano == ano && other.logo == logo;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nome.hashCode ^ ano.hashCode ^ logo.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory Campeonato.fromJson(String source) => Campeonato.fromMap(json.decode(source) as Map<String, dynamic>);
}
