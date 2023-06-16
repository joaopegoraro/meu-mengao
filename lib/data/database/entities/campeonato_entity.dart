// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:meu_mengao/data/models/campeonato.dart';

class CampeonatoEntity {
  CampeonatoEntity({
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

  Campeonato toCampeonato() {
    return Campeonato(
      id: id,
      nome: nome,
      ano: ano,
      logo: logo,
      rodadaAtual: rodadaAtual,
      possuiClassificacao: possuiClassificacao,
    );
  }

  factory CampeonatoEntity.fromCampeonato(Campeonato campeonato) {
    return CampeonatoEntity(
      id: campeonato.id,
      nome: campeonato.nome,
      ano: campeonato.ano,
      logo: campeonato.logo,
      rodadaAtual: campeonato.rodadaAtual,
      possuiClassificacao: campeonato.possuiClassificacao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _idColumn: id,
      _nomeColumn: nome,
      _anoColumn: ano,
      _logoColumn: logo,
      _rodadaAtualColumn: rodadaAtual,
      _possuiClassificacaoColumn: possuiClassificacao,
    };
  }

  factory CampeonatoEntity.fromMap(Map<String, dynamic> map) {
    return CampeonatoEntity(
      id: map[_idColumn] as String,
      nome: map[_nomeColumn] as String,
      ano: map[_anoColumn] as String,
      logo: map[_logoColumn] as String,
      rodadaAtual: map[_rodadaAtualColumn] as int,
      possuiClassificacao: map[_possuiClassificacaoColumn] as bool,
    );
  }

  static const _idColumn = "id";
  static const _nomeColumn = "nome";
  static const _anoColumn = "ano";
  static const _logoColumn = "logo";
  static const _rodadaAtualColumn = "rodadaAtual";
  static const _possuiClassificacaoColumn = "possuiClassificacao";

  static const tableName = "campeonatos";
  static const tableCreationStatement = """
  CREATE TABLE $tableName(
    $_idColumn VARCHAR(255) PRIMARY KEY, 
    $_anoColumn VARCHAR(255), 
    $_nomeColumn VARCHAR(255), 
    $_logoColumn TEXT,
    $_possuiClassificacaoColumn TINYINT(4), 
    $_rodadaAtualColumn INT(11))
  """;
}
