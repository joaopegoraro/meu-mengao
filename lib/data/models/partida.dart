// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    this.golsCasa,
    this.golsFora,
  });

  final String id;
  final String? campeonatoId;
  final DateTime? data;

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
    Time? timeCasa,
    Time? timeFora,
    int? golsCasa,
    int? golsFora,
  }) {
    return Partida(
      id: id ?? this.id,
      campeonatoId: campeonatoId ?? this.campeonatoId,
      data: data ?? this.data,
      timeCasa: timeCasa ?? this.timeCasa,
      timeFora: timeFora ?? this.timeFora,
      golsCasa: golsCasa ?? this.golsCasa,
      golsFora: golsFora ?? this.golsFora,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'campeonatoId': campeonatoId,
      'data': data,
      'timeCasa': timeCasa,
      'golsCasa': golsCasa,
      'timeFora': timeFora,
      'golsFora': golsFora,
    };
  }

  factory Partida.fromMap(Map<String, dynamic> map) {
    return Partida(
      id: map['id'] ?? "",
      campeonatoId: map['campeonatoId'] != null ? map['campeonatoId'] ?? "" : null,
      data: DateTime.tryParse(map['data'])?.toLocal(),
      timeCasa: Time(nome: map['timeCasa'], escudo: map['escudoCasa']),
      timeFora: Time(nome: map['timeFora'], escudo: map['escudoFora']),
      golsCasa: map['golsCasa'],
      golsFora: map['golsFora'],
    );
  }

  @override
  String toString() {
    return 'Partida(id: $id, campeonatoId: $campeonatoId, data: $data, timeCasa: $timeCasa, golsCasa: $golsCasa, timeFora: $timeFora, golsFora: $golsFora)';
  }

  @override
  bool operator ==(covariant Partida other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.campeonatoId == campeonatoId &&
        other.data == data &&
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
        timeCasa.hashCode ^
        golsCasa.hashCode ^
        timeFora.hashCode ^
        golsFora.hashCode;
  }
}
