// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';

import '../../utils/date_utils.dart';

class Partida {
  Partida({
    required this.id,
    required this.campeonato,
    required this.campeonatoId,
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
  final String campeonatoId;
  final DateTime? data;

  final String? rodadaName;
  final int? rodadaIndex;

  String? get readableDate {
    if (data == null) return null;
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    final tomorrow = now.add(const Duration(days: 1));
    final dayDifference = data!.difference(now).inDays;
    if (DateUtils.areDatesSameDay(data!, yesterday)) return "Ontem";
    if (DateUtils.areDatesSameDay(data!, now)) return "Hoje";
    if (DateUtils.areDatesSameDay(data!, tomorrow)) return "Amanhã";
    if (dayDifference > 1 && dayDifference <= 6) {
      // "Segunda-feira"
      return DateFormat('EEEE').format(data!).split('-').first;
    }
    return DateFormat.MMMd(Platform.localeName).format(data!); // "25 de maio"
  }

  String? get horario {
    if (data == null) return null;
    return DateFormat.Hm().format(data!);
  }

  final String timeCasa;
  final int? golsCasa;

  final String timeFora;
  final int? golsFora;

  final String escudoCasa;
  final String escudoFora;

  bool get isCorrupted => id.isEmpty || timeCasa.isEmpty || timeFora.isEmpty;

  Partida copyWith({
    String? id,
    String? campeonato,
    String? campeonatoId,
    DateTime? data,
    String? rodadaName,
    int? rodadaIndex,
    String? timeCasa,
    int? golsCasa,
    String? timeFora,
    int? golsFora,
    String? escudoCasa,
    String? escudoFora,
  }) {
    return Partida(
      id: id ?? this.id,
      campeonato: campeonato ?? this.campeonato,
      campeonatoId: campeonatoId ?? this.campeonatoId,
      data: data ?? this.data,
      rodadaName: rodadaName ?? this.rodadaName,
      rodadaIndex: rodadaIndex ?? this.rodadaIndex,
      timeCasa: timeCasa ?? this.timeCasa,
      golsCasa: golsCasa ?? this.golsCasa,
      timeFora: timeFora ?? this.timeFora,
      golsFora: golsFora ?? this.golsFora,
      escudoCasa: escudoCasa ?? this.escudoCasa,
      escudoFora: escudoFora ?? this.escudoFora,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'campeonato': campeonato,
      'campeonatoId': campeonatoId,
      'data': data?.millisecondsSinceEpoch.toString(),
      'rodadaName': rodadaName,
      'rodadaIndex': rodadaIndex,
      'timeCasa': timeCasa,
      'golsCasa': golsCasa,
      'timeFora': timeFora,
      'golsFora': golsFora,
      'escudoCasa': escudoCasa,
      'escudoFora': escudoFora,
    };
  }

  factory Partida.fromMap(Map<String, dynamic> map) {
    return Partida(
      id: map['id'] as String,
      campeonato: map['campeonato'] as String,
      campeonatoId: map['campeonatoId'] as String,
      data: map['data'] != null ? DateTime.fromMillisecondsSinceEpoch(int.tryParse(map['data']) ?? 0) : null,
      rodadaName: map['rodadaName'] != null ? map['rodadaName'] as String : null,
      rodadaIndex: map['rodadaIndex'] as int?,
      timeCasa: map['timeCasa'] as String,
      golsCasa: int.tryParse(map['golsCasa']),
      timeFora: map['timeFora'] as String,
      golsFora: int.tryParse(map['golsFora']),
      escudoCasa: map['escudoCasa'] as String,
      escudoFora: map['escudoFora'] as String,
    );
  }

  @override
  String toString() {
    return 'Partida(id: $id, campeonato: $campeonato, campeonatoId: $campeonatoId, data: $data, rodadaName: $rodadaName, rodadaIndex: $rodadaIndex, timeCasa: $timeCasa, golsCasa: $golsCasa, timeFora: $timeFora, golsFora: $golsFora, escudoCasa: $escudoCasa, escudoFora: $escudoFora)';
  }

  @override
  bool operator ==(covariant Partida other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.campeonato == campeonato &&
        other.campeonatoId == campeonatoId &&
        other.data == data &&
        other.rodadaName == rodadaName &&
        other.rodadaIndex == rodadaIndex &&
        other.timeCasa == timeCasa &&
        other.golsCasa == golsCasa &&
        other.timeFora == timeFora &&
        other.golsFora == golsFora &&
        other.escudoCasa == escudoCasa &&
        other.escudoFora == escudoFora;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        campeonato.hashCode ^
        campeonatoId.hashCode ^
        data.hashCode ^
        rodadaName.hashCode ^
        rodadaIndex.hashCode ^
        timeCasa.hashCode ^
        golsCasa.hashCode ^
        timeFora.hashCode ^
        golsFora.hashCode ^
        escudoCasa.hashCode ^
        escudoFora.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory Partida.fromJson(String source) => Partida.fromMap(json.decode(source) as Map<String, dynamic>);
}
