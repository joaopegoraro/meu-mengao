// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:meu_mengao/data/models/time.dart';

class Partida {
  Partida({
    required this.id,
    required this.timeCasa,
    required this.timeFora,
    this.campeonatoId,
    this.data,
    this.mataMataName,
    this.mataMataIndex,
    this.golsCasa,
    this.golsFora,
  });

  final String id;
  final String? campeonatoId;
  final DateTime? data;

  final String? mataMataName;
  final String? mataMataIndex;

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

  final Time timeCasa;
  final int? golsCasa;

  final Time timeFora;
  final int? golsFora;

  bool get isCorrupted => id.isEmpty || timeCasa.isCorrupted || timeFora.isCorrupted;

  Partida copyWith({
    String? id,
    String? campeonatoId,
    DateTime? data,
    String? mataMataName,
    String? mataMataIndex,
    Time? timeCasa,
    int? golsCasa,
    Time? timeFora,
    int? golsFora,
  }) {
    return Partida(
      id: id ?? this.id,
      campeonatoId: campeonatoId ?? this.campeonatoId,
      data: data ?? this.data,
      mataMataName: mataMataName ?? this.mataMataName,
      mataMataIndex: mataMataIndex ?? this.mataMataIndex,
      timeCasa: timeCasa ?? this.timeCasa,
      golsCasa: golsCasa ?? this.golsCasa,
      timeFora: timeFora ?? this.timeFora,
      golsFora: golsFora ?? this.golsFora,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'campeonatoId': campeonatoId,
      'data': data?.millisecondsSinceEpoch,
      'mataMataName': mataMataName,
      'mataMataIndex': mataMataIndex,
      'timeCasa': timeCasa.toMap(),
      'golsCasa': golsCasa,
      'timeFora': timeFora.toMap(),
      'golsFora': golsFora,
    };
  }

  factory Partida.fromMap(Map<String, dynamic> map) {
    return Partida(
      id: map['id'] as String,
      campeonatoId: map['campeonatoId'] != null ? map['campeonatoId'] as String : null,
      data: map['data'] != null ? DateTime.fromMillisecondsSinceEpoch(map['data'] as int) : null,
      mataMataName: map['mataMataName'] != null ? map['mataMataName'] as String : null,
      mataMataIndex: map['mataMataIndex'] != null ? map['mataMataIndex'] as String : null,
      timeCasa: Time.fromMap(map['timeCasa'] as Map<String, dynamic>),
      golsCasa: map['golsCasa'] != null ? map['golsCasa'] as int : null,
      timeFora: Time.fromMap(map['timeFora'] as Map<String, dynamic>),
      golsFora: map['golsFora'] != null ? map['golsFora'] as int : null,
    );
  }

  @override
  String toString() {
    return 'Partida(id: $id, campeonatoId: $campeonatoId, data: $data, mataMataName: $mataMataName, mataMataIndex: $mataMataIndex, timeCasa: $timeCasa, golsCasa: $golsCasa, timeFora: $timeFora, golsFora: $golsFora)';
  }

  @override
  bool operator ==(covariant Partida other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.campeonatoId == campeonatoId &&
        other.data == data &&
        other.mataMataName == mataMataName &&
        other.mataMataIndex == mataMataIndex &&
        other.timeCasa == timeCasa &&
        other.golsCasa == golsCasa &&
        other.timeFora == timeFora &&
        other.golsFora == golsFora;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        campeonatoId.hashCode ^
        data.hashCode ^
        mataMataName.hashCode ^
        mataMataIndex.hashCode ^
        timeCasa.hashCode ^
        golsCasa.hashCode ^
        timeFora.hashCode ^
        golsFora.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory Partida.fromJson(String source) => Partida.fromMap(json.decode(source) as Map<String, dynamic>);
}
