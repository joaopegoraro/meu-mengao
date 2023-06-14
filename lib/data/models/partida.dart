// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:meu_mengao/data/models/posicao.dart';

class Partida {
  Partida({
    required this.id,
    required this.campeonatoName,
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
  final String campeonatoName;
  final DateTime? data;

  final String? rodadaName;
  final String? rodadaIndex;

  String? get readableDate {
    if (data == null) return null;
    final now = DateTime.now();
    final dayDifference = data!.difference(now).inDays;
    if (dayDifference == -1) return "Ontem";
    if (dayDifference == 0) return "Hoje - ${DateFormat.Hm().format(data!)}"; // "Hoje - 21:30"
    if (dayDifference == 1) return "Amanhã - ${DateFormat.Hm().format(data!)}"; // "Amanhã - 21:30"
    if (dayDifference > 1 && dayDifference <= 6) {
      // "Segunda-feira - 21:30"
      return "${DateFormat('EEEE').format(data!)} - ${DateFormat.Hm(Platform.localeName).format(data!)}";
    }
    return DateFormat.MMMMd(Platform.localeName).add_Hm().format(data!); // "25 de maio, 22:30"
  }

  final Posicao timeCasa;
  final int? golsCasa;

  final Posicao timeFora;
  final int? golsFora;

  final String escudoCasa;
  final String escudoFora;

  bool get isCorrupted => id.isEmpty || timeCasa.isCorrupted || timeFora.isCorrupted;

  Partida copyWith({
    String? id,
    String? campeonatoName,
    DateTime? data,
    String? rodadaName,
    String? rodadaIndex,
    Posicao? timeCasa,
    int? golsCasa,
    Posicao? timeFora,
    int? golsFora,
    String? escudoCasa,
    String? escudoFora,
  }) {
    return Partida(
      id: id ?? this.id,
      campeonatoName: campeonatoName ?? this.campeonatoName,
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
      'campeonatoName': campeonatoName,
      'data': data?.millisecondsSinceEpoch,
      'rodadaName': rodadaName,
      'rodadaIndex': rodadaIndex,
      'timeCasa': timeCasa.toMap(),
      'golsCasa': golsCasa,
      'timeFora': timeFora.toMap(),
      'golsFora': golsFora,
      'escudoCasa': escudoCasa,
      'escudoFora': escudoFora,
    };
  }

  factory Partida.fromMap(Map<String, dynamic> map) {
    return Partida(
      id: map['id'] as String,
      campeonatoName: map['campeonatoName'] as String,
      data: map['data'] != null ? DateTime.fromMillisecondsSinceEpoch(map['data'] as int) : null,
      rodadaName: map['rodadaName'] != null ? map['rodadaName'] as String : null,
      rodadaIndex: map['rodadaIndex'] != null ? map['rodadaIndex'] as String : null,
      timeCasa: Posicao.fromMap(map['timeCasa'] as Map<String, dynamic>),
      golsCasa: map['golsCasa'] != null ? map['golsCasa'] as int : null,
      timeFora: Posicao.fromMap(map['timeFora'] as Map<String, dynamic>),
      golsFora: map['golsFora'] != null ? map['golsFora'] as int : null,
      escudoCasa: map['escudoCasa'] as String,
      escudoFora: map['escudoFora'] as String,
    );
  }

  @override
  String toString() {
    return 'Partida(id: $id, campeonatoName: $campeonatoName, data: $data, rodadaName: $rodadaName, rodadaIndex: $rodadaIndex, timeCasa: $timeCasa, golsCasa: $golsCasa, timeFora: $timeFora, golsFora: $golsFora, escudoCasa: $escudoCasa, escudoFora: $escudoFora)';
  }

  @override
  bool operator ==(covariant Partida other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.campeonatoName == campeonatoName &&
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
        campeonatoName.hashCode ^
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
