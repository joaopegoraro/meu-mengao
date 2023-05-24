import 'dart:convert';

class Posicao {
  Posicao({
    required this.posicao,
    required this.time,
    this.escudoTime,
    this.pontos = 0,
    this.vitorias = 0,
    this.empates = 0,
    this.derrotas = 0,
    this.golsFeitos = 0,
    this.golsSofridos = 0,
    this.saldoGols = 0,
  });

  final int posicao;
  final String time;
  final String? escudoTime;
  final int pontos;
  final int vitorias;
  final int empates;
  final int derrotas;
  final int golsFeitos;
  final int golsSofridos;
  final int saldoGols;

  bool get isCorrupted => posicao <= 0 || time.isEmpty;

  Posicao copyWith({
    int? posicao,
    String? time,
    String? escudoTime,
    int? pontos,
    int? vitorias,
    int? empates,
    int? derrotas,
    int? golsFeitos,
    int? golsSofridos,
    int? saldoGols,
  }) {
    return Posicao(
      posicao: posicao ?? this.posicao,
      time: time ?? this.time,
      escudoTime: escudoTime ?? this.escudoTime,
      pontos: pontos ?? this.pontos,
      vitorias: vitorias ?? this.vitorias,
      empates: empates ?? this.empates,
      derrotas: derrotas ?? this.derrotas,
      golsFeitos: golsFeitos ?? this.golsFeitos,
      golsSofridos: golsSofridos ?? this.golsSofridos,
      saldoGols: saldoGols ?? this.saldoGols,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'posicao': posicao,
      'time': time,
      'escudoTime': escudoTime,
      'pontos': pontos,
      'vitorias': vitorias,
      'empates': empates,
      'derrotas': derrotas,
      'golsFeitos': golsFeitos,
      'golsSofridos': golsSofridos,
      'saldoGols': saldoGols,
    };
  }

  factory Posicao.fromMap(Map<String, dynamic> map) {
    return Posicao(
      posicao: map['posicao'] ?? 0,
      time: map['time'] ?? "",
      escudoTime: map['escudoTime'] != null ? map['escudoTime'] ?? "" : null,
      pontos: map['pontos'] ?? 0,
      vitorias: map['vitorias'] ?? 0,
      empates: map['empates'] ?? 0,
      derrotas: map['derrotas'] ?? 0,
      golsFeitos: map['golsFeitos'] ?? 0,
      golsSofridos: map['golsSofridos'] ?? 0,
      saldoGols: map['saldoGols'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Posicao.fromJson(String source) => Posicao.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Posicao(posicao: $posicao, time: $time, escudoTime: $escudoTime, pontos: $pontos, vitorias: $vitorias, empates: $empates, derrotas: $derrotas, golsFeitos: $golsFeitos, golsSofridos: $golsSofridos, saldoGols: $saldoGols)';
  }

  @override
  bool operator ==(covariant Posicao other) {
    if (identical(this, other)) return true;

    return other.posicao == posicao &&
        other.time == time &&
        other.escudoTime == escudoTime &&
        other.pontos == pontos &&
        other.vitorias == vitorias &&
        other.empates == empates &&
        other.derrotas == derrotas &&
        other.golsFeitos == golsFeitos &&
        other.golsSofridos == golsSofridos &&
        other.saldoGols == saldoGols;
  }

  @override
  int get hashCode {
    return posicao.hashCode ^
        time.hashCode ^
        escudoTime.hashCode ^
        pontos.hashCode ^
        vitorias.hashCode ^
        empates.hashCode ^
        derrotas.hashCode ^
        golsFeitos.hashCode ^
        golsSofridos.hashCode ^
        saldoGols.hashCode;
  }
}
