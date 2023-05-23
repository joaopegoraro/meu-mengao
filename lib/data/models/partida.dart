// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Partida {
  Partida({
    required this.id,
    required this.timeCasa,
    required this.timeFora,
    this.campeonatoId,
    this.data,
    this.escudoCasa,
    this.golsCasa,
    this.escudoFora,
    this.golsFora,
  });

  final String id;
  final String? campeonatoId;
  final String? data;

  final String timeCasa;
  final String? escudoCasa;
  final int? golsCasa;

  final String timeFora;
  final String? escudoFora;
  final int? golsFora;

  Partida copyWith({
    String? id,
    String? campeonatoId,
    String? data,
    String? timeCasa,
    String? escudoCasa,
    int? golsCasa,
    String? timeFora,
    String? escudoFora,
    int? golsFora,
  }) {
    return Partida(
      id: id ?? this.id,
      campeonatoId: campeonatoId ?? this.campeonatoId,
      data: data ?? this.data,
      timeCasa: timeCasa ?? this.timeCasa,
      escudoCasa: escudoCasa ?? this.escudoCasa,
      golsCasa: golsCasa ?? this.golsCasa,
      timeFora: timeFora ?? this.timeFora,
      escudoFora: escudoFora ?? this.escudoFora,
      golsFora: golsFora ?? this.golsFora,
    );
  }

  bool isCorrupted() {
    return id.isEmpty || timeCasa.isEmpty || timeFora.isEmpty;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'campeonatoId': campeonatoId,
      'data': data,
      'timeCasa': timeCasa,
      'escudoCasa': escudoCasa,
      'golsCasa': golsCasa,
      'timeFora': timeFora,
      'escudoFora': escudoFora,
      'golsFora': golsFora,
    };
  }

  factory Partida.fromMap(Map<String, dynamic> map) {
    return Partida(
      id: map['id'] ?? "",
      campeonatoId: map['campeonatoId'] != null ? map['campeonatoId'] ?? "" : null,
      data: map['data'] != null ? map['data'] ?? "" : null,
      timeCasa: map['timeCasa'] ?? "",
      escudoCasa: map['escudoCasa'] != null ? map['escudoCasa'] ?? "" : null,
      golsCasa: map['golsCasa'],
      timeFora: map['timeFora'] ?? "",
      escudoFora: map['escudoFora'] != null ? map['escudoFora'] ?? "" : null,
      golsFora: map['golsFora'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Partida.fromJson(String source) => Partida.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Partida(id: $id, campeonatoId: $campeonatoId, data: $data, timeCasa: $timeCasa, escudoCasa: $escudoCasa, golsCasa: $golsCasa, timeFora: $timeFora, escudoFora: $escudoFora, golsFora: $golsFora)';
  }

  @override
  bool operator ==(covariant Partida other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.campeonatoId == campeonatoId &&
        other.data == data &&
        other.timeCasa == timeCasa &&
        other.escudoCasa == escudoCasa &&
        other.golsCasa == golsCasa &&
        other.timeFora == timeFora &&
        other.escudoFora == escudoFora &&
        other.golsFora == golsFora;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        campeonatoId.hashCode ^
        data.hashCode ^
        timeCasa.hashCode ^
        escudoCasa.hashCode ^
        golsCasa.hashCode ^
        timeFora.hashCode ^
        escudoFora.hashCode ^
        golsFora.hashCode;
  }
}
