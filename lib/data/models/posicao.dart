// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Posicao {
  Posicao({
    required this.id,
    this.posicao,
    required this.nome,
    this.escudo,
    this.pontos = 0,
    this.jogos = 0,
    this.vitorias = 0,
    this.empates = 0,
    this.derrotas = 0,
    this.golsFeitos = 0,
    this.golsSofridos = 0,
    this.saldoGols = 0,
    required this.classificacaoId,
    required this.classificacaoName,
    required this.classificacaoIndex,
  });

  final String id;
  final int? posicao;
  final String nome;
  final String? escudo;
  final int pontos;
  final int jogos;
  final int vitorias;
  final int empates;
  final int derrotas;
  final int golsFeitos;
  final int golsSofridos;
  final int saldoGols;
  final String classificacaoId;
  final String classificacaoName;
  final String classificacaoIndex;

  bool get isCorrupted => nome.isEmpty;

  Posicao copyWith({
    String? id,
    int? posicao,
    String? nome,
    String? escudo,
    int? pontos,
    int? jogos,
    int? vitorias,
    int? empates,
    int? derrotas,
    int? golsFeitos,
    int? golsSofridos,
    int? saldoGols,
    String? classificacaoId,
    String? classificacaoName,
    String? classificacaoIndex,
  }) {
    return Posicao(
      id: id ?? this.id,
      posicao: posicao ?? this.posicao,
      nome: nome ?? this.nome,
      escudo: escudo ?? this.escudo,
      pontos: pontos ?? this.pontos,
      jogos: jogos ?? this.jogos,
      vitorias: vitorias ?? this.vitorias,
      empates: empates ?? this.empates,
      derrotas: derrotas ?? this.derrotas,
      golsFeitos: golsFeitos ?? this.golsFeitos,
      golsSofridos: golsSofridos ?? this.golsSofridos,
      saldoGols: saldoGols ?? this.saldoGols,
      classificacaoId: classificacaoId ?? this.classificacaoId,
      classificacaoName: classificacaoName ?? this.classificacaoName,
      classificacaoIndex: classificacaoIndex ?? this.classificacaoIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'posicao': posicao,
      'nome': nome,
      'escudo': escudo,
      'pontos': pontos,
      'jogos': jogos,
      'vitorias': vitorias,
      'empates': empates,
      'derrotas': derrotas,
      'golsFeitos': golsFeitos,
      'golsSofridos': golsSofridos,
      'saldoGols': saldoGols,
      'classificacaoId': classificacaoId,
      'classificacaoName': classificacaoName,
      'classificacaoIndex': classificacaoIndex,
    };
  }

  factory Posicao.fromMap(Map<String, dynamic> map) {
    return Posicao(
      id: map['id'] as String,
      posicao: map['posicao'] != null ? map['posicao'] as int : null,
      nome: map['nome'] as String,
      escudo: map['escudo'] != null ? map['escudo'] as String : null,
      pontos: map['pontos'] as int,
      jogos: map['jogos'] as int,
      vitorias: map['vitorias'] as int,
      empates: map['empates'] as int,
      derrotas: map['derrotas'] as int,
      golsFeitos: map['golsFeitos'] as int,
      golsSofridos: map['golsSofridos'] as int,
      saldoGols: map['saldoGols'] as int,
      classificacaoId: map['classificacaoId'] as String,
      classificacaoName: map['classificacaoName'] as String,
      classificacaoIndex: map['classificacaoIndex'] as String,
    );
  }

  @override
  String toString() {
    return 'Posicao(id: $id, posicao: $posicao, nome: $nome, escudo: $escudo, pontos: $pontos, jogos: $jogos, vitorias: $vitorias, empates: $empates, derrotas: $derrotas, golsFeitos: $golsFeitos, golsSofridos: $golsSofridos, saldoGols: $saldoGols, classificacaoId: $classificacaoId, classificacaoName: $classificacaoName, classificacaoIndex: $classificacaoIndex)';
  }

  @override
  bool operator ==(covariant Posicao other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.posicao == posicao &&
        other.nome == nome &&
        other.escudo == escudo &&
        other.pontos == pontos &&
        other.jogos == jogos &&
        other.vitorias == vitorias &&
        other.empates == empates &&
        other.derrotas == derrotas &&
        other.golsFeitos == golsFeitos &&
        other.golsSofridos == golsSofridos &&
        other.saldoGols == saldoGols &&
        other.classificacaoId == classificacaoId &&
        other.classificacaoName == classificacaoName &&
        other.classificacaoIndex == classificacaoIndex;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        posicao.hashCode ^
        nome.hashCode ^
        escudo.hashCode ^
        pontos.hashCode ^
        jogos.hashCode ^
        vitorias.hashCode ^
        empates.hashCode ^
        derrotas.hashCode ^
        golsFeitos.hashCode ^
        golsSofridos.hashCode ^
        saldoGols.hashCode ^
        classificacaoId.hashCode ^
        classificacaoName.hashCode ^
        classificacaoIndex.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory Posicao.fromJson(String source) => Posicao.fromMap(json.decode(source) as Map<String, dynamic>);
}
