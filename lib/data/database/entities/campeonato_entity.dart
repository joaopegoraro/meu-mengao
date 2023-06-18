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

  final String? id;
  final String? nome;
  final String? ano;
  final String? logo;
  final int? rodadaAtual;
  final bool? possuiClassificacao;

  Campeonato toCampeonato() {
    return Campeonato(
      id: id ?? "",
      nome: nome ?? "",
      ano: ano ?? "",
      logo: logo ?? "",
      rodadaAtual: rodadaAtual ?? 0,
      possuiClassificacao: possuiClassificacao ?? false,
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
      idColumn: id,
      nomeColumn: nome,
      anoColumn: ano,
      logoColumn: logo,
      rodadaAtualColumn: rodadaAtual,
      possuiClassificacaoColumn: possuiClassificacao == true ? 1 : 0,
    };
  }

  factory CampeonatoEntity.fromMap(Map<String, dynamic> map) {
    return CampeonatoEntity(
      id: map[idColumn] as String?,
      nome: map[nomeColumn] as String?,
      ano: map[anoColumn] as String?,
      logo: map[logoColumn] as String?,
      rodadaAtual: map[rodadaAtualColumn] as int?,
      possuiClassificacao: (map[possuiClassificacaoColumn] as int?) != 0,
    );
  }

  static const idColumn = "id";
  static const nomeColumn = "nome";
  static const anoColumn = "ano";
  static const logoColumn = "logo";
  static const rodadaAtualColumn = "rodadaAtual";
  static const possuiClassificacaoColumn = "possuiClassificacao";

  static const tableName = "campeonatos";
  static const tableCreationStatement = """
  CREATE TABLE $tableName(
    $idColumn VARCHAR(255) PRIMARY KEY, 
    $anoColumn VARCHAR(255), 
    $nomeColumn VARCHAR(255), 
    $logoColumn TEXT,
    $possuiClassificacaoColumn TINYINT(4), 
    $rodadaAtualColumn INT(11))
  """;
}
