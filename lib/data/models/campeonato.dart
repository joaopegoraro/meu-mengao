// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Campeonato {
  Campeonato({
    required this.id,
    required this.nome,
    required this.ano,
    required this.logo,
    required this.rodadaAtual,
    required this.possuiClassificacao,
  });

  final String id;
  final String nome;
  final String ano;
  final String logo;
  final int rodadaAtual;
  final bool possuiClassificacao;

  bool get isCorrupted => id.isEmpty || nome.isEmpty;

  Campeonato copyWith({
    String? id,
    String? nome,
    String? ano,
    String? logo,
    int? rodadaAtual,
    bool? possuiClassificacao,
  }) {
    return Campeonato(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      ano: ano ?? this.ano,
      logo: logo ?? this.logo,
      rodadaAtual: rodadaAtual ?? this.rodadaAtual,
      possuiClassificacao: possuiClassificacao ?? this.possuiClassificacao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'ano': ano,
      'logo': logo,
      'rodadaAtual': rodadaAtual,
      'possuiClassificacao': possuiClassificacao,
    };
  }

  factory Campeonato.fromMap(Map<String, dynamic> map) {
    return Campeonato(
      id: map['id'] as String,
      nome: map['nome'] as String,
      ano: map['ano'] as String,
      logo: map['logo'] as String,
      rodadaAtual: map['rodadaAtual'] as int,
      possuiClassificacao: map['possuiClassificacao'] as bool,
    );
  }

  @override
  String toString() {
    return 'Campeonato(id: $id, nome: $nome, ano: $ano, logo: $logo, rodadaAtual: $rodadaAtual, possuiClassificacao: $possuiClassificacao)';
  }

  @override
  bool operator ==(covariant Campeonato other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        other.ano == ano &&
        other.logo == logo &&
        other.rodadaAtual == rodadaAtual &&
        other.possuiClassificacao == possuiClassificacao;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        ano.hashCode ^
        logo.hashCode ^
        rodadaAtual.hashCode ^
        possuiClassificacao.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory Campeonato.fromJson(String source) => Campeonato.fromMap(json.decode(source) as Map<String, dynamic>);
}
