// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:meu_mengao/data/models/partida.dart';

class PartidaEntity {
  PartidaEntity({
    required this.id,
    required this.campeonato,
    this.data,
    this.rodadaName,
    this.rodadaIndex,
    required this.timeCasa,
    this.golsCasa,
    required this.timeFora,
    this.golsFora,
    required this.escudoCasa,
    required this.escudoFora,
  });

  final String id;
  final String campeonato;
  final DateTime? data;

  final String? rodadaName;
  final int? rodadaIndex;

  final String timeCasa;
  final int? golsCasa;

  final String timeFora;
  final int? golsFora;

  final String escudoCasa;
  final String escudoFora;

  Partida toPartida() {
    return Partida(
      id: id,
      campeonato: campeonato,
      timeCasa: timeCasa,
      timeFora: timeFora,
      escudoCasa: escudoCasa,
      escudoFora: escudoFora,
    );
  }

  factory PartidaEntity.fromPartida(Partida partida) {
    return PartidaEntity(
      id: partida.id,
      campeonato: partida.campeonato,
      timeCasa: partida.timeCasa,
      timeFora: partida.timeFora,
      escudoCasa: partida.escudoCasa,
      escudoFora: partida.escudoFora,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _idColumn: id,
      _campeonatoColumn: campeonato,
      _dataColumn: data?.millisecondsSinceEpoch.toString(),
      _rodadaNameColumn: rodadaName,
      _rodadaIndexColumn: rodadaIndex,
      _timeCasaColumn: timeCasa,
      _golsCasaColumn: golsCasa,
      _timeForaColumn: timeFora,
      _golsForaColumn: golsFora,
      _escudoCasaColumn: escudoCasa,
      _escudoForaColumn: escudoFora,
    };
  }

  factory PartidaEntity.fromMap(Map<String, dynamic> map) {
    return PartidaEntity(
      id: map[_idColumn] as String,
      campeonato: map[_campeonatoColumn] as String,
      data: map[_dataColumn] != null ? DateTime.fromMillisecondsSinceEpoch(int.tryParse(map[_dataColumn]) ?? 0) : null,
      rodadaName: map[_rodadaNameColumn] != null ? map[_rodadaNameColumn] as String : null,
      rodadaIndex: map[_rodadaIndexColumn] as int?,
      timeCasa: map[_timeCasaColumn] as String,
      golsCasa: int.tryParse(map[_golsCasaColumn]),
      timeFora: map[_timeForaColumn] as String,
      golsFora: int.tryParse(map[_golsForaColumn]),
      escudoCasa: map[_escudoCasaColumn] as String,
      escudoFora: map[_escudoForaColumn] as String,
    );
  }

  static const _idColumn = "id";
  static const _dataColumn = "data";
  static const _timeCasaColumn = "timeCasa";
  static const _timeForaColumn = "timeFora";
  static const _escudoCasaColumn = "escudoCasa";
  static const _escudoForaColumn = "escudoFora";
  static const _golsCasaColumn = "golsCasa";
  static const _golsForaColumn = "golsFora";
  static const _campeonatoColumn = "campeonato";
  static const _rodadaNameColumn = "rodadaName";
  static const _rodadaIndexColumn = "rodadaIndex";

  static const tableName = "partidas";
  static const tableCreationStatement = """
  CREATE TABLE $tableName(
    $_idColumn VARCHAR(255) PRIMARY KEY, 
    $_dataColumn VARCHAR(255), 
    $_timeCasaColumn VARCHAR(255), 
    $_timeForaColumn VARCHAR(255), 
    $_escudoCasaColumn TEXT,
    $_escudoForaColumn TEXT,
    $_golsCasaColumn VARCHAR(255), 
    $_golsForaColumn VARCHAR(255), 
    $_campeonatoColumn VARCHAR(255), 
    $_rodadaNameColumn VARCHAR(255), 
    $_rodadaIndexColumn INT(11))
  """;
}
