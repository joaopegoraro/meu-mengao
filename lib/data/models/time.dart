class Time {
  Time({
    this.posicao,
    required this.nome,
    this.escudo,
    this.pontos = 0,
    this.vitorias = 0,
    this.empates = 0,
    this.derrotas = 0,
    this.golsFeitos = 0,
    this.golsSofridos = 0,
    this.saldoGols = 0,
  });

  final int? posicao;
  final String nome;
  final String? escudo;
  final int pontos;
  final int vitorias;
  final int empates;
  final int derrotas;
  final int golsFeitos;
  final int golsSofridos;
  final int saldoGols;

  bool get isCorrupted => nome.isEmpty;

  factory Time.corrupted() => Time(nome: "");

  Time copyWith({
    int? posicao,
    String? nome,
    String? escudo,
    int? pontos,
    int? vitorias,
    int? empates,
    int? derrotas,
    int? golsFeitos,
    int? golsSofridos,
    int? saldoGols,
  }) {
    return Time(
      posicao: posicao ?? this.posicao,
      nome: nome ?? this.nome,
      escudo: escudo ?? this.escudo,
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
      'time': nome,
      'escudoTime': escudo,
      'pontos': pontos,
      'vitorias': vitorias,
      'empates': empates,
      'derrotas': derrotas,
      'golsFeitos': golsFeitos,
      'golsSofridos': golsSofridos,
      'saldoGols': saldoGols,
    };
  }

  factory Time.fromMap(Map<String, dynamic> map) {
    return Time(
      posicao: map['posicao'],
      nome: map['time'] ?? "",
      escudo: map['escudoTime'],
      pontos: map['pontos'] ?? 0,
      vitorias: map['vitorias'] ?? 0,
      empates: map['empates'] ?? 0,
      derrotas: map['derrotas'] ?? 0,
      golsFeitos: map['golsFeitos'] ?? 0,
      golsSofridos: map['golsSofridos'] ?? 0,
      saldoGols: map['saldoGols'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Posicao(posicao: $posicao, time: $nome, escudoTime: $escudo, pontos: $pontos, vitorias: $vitorias, empates: $empates, derrotas: $derrotas, golsFeitos: $golsFeitos, golsSofridos: $golsSofridos, saldoGols: $saldoGols)';
  }

  @override
  bool operator ==(covariant Time other) {
    if (identical(this, other)) return true;

    return other.posicao == posicao &&
        other.nome == nome &&
        other.escudo == escudo &&
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
        nome.hashCode ^
        escudo.hashCode ^
        pontos.hashCode ^
        vitorias.hashCode ^
        empates.hashCode ^
        derrotas.hashCode ^
        golsFeitos.hashCode ^
        golsSofridos.hashCode ^
        saldoGols.hashCode;
  }
}
