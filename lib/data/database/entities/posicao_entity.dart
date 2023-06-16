// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:meu_mengao/data/models/posicao.dart';

class PosicaoEntity {
  PosicaoEntity({
    required this.id,
    required this.posicao,
    required this.nomeTime,
    this.escudoTime,
    required this.pontos,
    required this.jogos,
    required this.vitorias,
    required this.empates,
    required this.derrotas,
    required this.golsFeitos,
    required this.golsSofridos,
    required this.saldoGols,
    required this.classificacaoName,
    required this.classificacaoIndex,
  });

  final String id;
  final int posicao;
  final String nomeTime;
  final String? escudoTime;
  final String pontos;
  final String jogos;
  final String vitorias;
  final String empates;
  final String derrotas;
  final String golsFeitos;
  final String golsSofridos;
  final String saldoGols;
  final String classificacaoName;
  final int classificacaoIndex;

  Posicao toPosicao() {
    return Posicao(
      id: id,
      posicao: posicao,
      nomeTime: nomeTime,
      pontos: pontos,
      jogos: jogos,
      vitorias: vitorias,
      empates: empates,
      derrotas: derrotas,
      golsFeitos: golsFeitos,
      golsSofridos: golsSofridos,
      saldoGols: saldoGols,
      classificacaoName: classificacaoName,
      classificacaoIndex: classificacaoIndex,
    );
  }

  factory PosicaoEntity.fromPosicao(Posicao posicao) {
    return PosicaoEntity(
      id: posicao.id,
      posicao: posicao.posicao,
      nomeTime: posicao.nomeTime,
      pontos: posicao.pontos,
      jogos: posicao.jogos,
      vitorias: posicao.vitorias,
      empates: posicao.empates,
      derrotas: posicao.derrotas,
      golsFeitos: posicao.golsFeitos,
      golsSofridos: posicao.golsSofridos,
      saldoGols: posicao.saldoGols,
      classificacaoName: posicao.classificacaoName,
      classificacaoIndex: posicao.classificacaoIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _idColumn: id,
      _posicaoColumn: posicao,
      _nomeTimeColumn: nomeTime,
      _escudoTimeColumn: escudoTime,
      _pontosColumn: pontos,
      _jogosColumn: jogos,
      _vitoriasColumn: vitorias,
      _empatesColumn: empates,
      _derrotasColumn: derrotas,
      _golsFeitosColumn: golsFeitos,
      _golsSofridosColumn: golsSofridos,
      _saldoGolsColumn: saldoGols,
      _classificacaoNameColumn: classificacaoName,
      _classificacaoIndexColumn: classificacaoIndex,
    };
  }

  factory PosicaoEntity.fromMap(Map<String, dynamic> map) {
    return PosicaoEntity(
      id: map[_idColumn] as String,
      posicao: int.tryParse(map[_posicaoColumn]) ?? 0,
      nomeTime: map[_nomeTimeColumn] as String,
      escudoTime: map[_escudoTimeColumn] != null ? map[_escudoTimeColumn] as String : null,
      pontos: map[_pontosColumn] as String,
      jogos: map[_jogosColumn] as String,
      vitorias: map[_vitoriasColumn] as String,
      empates: map[_empatesColumn] as String,
      derrotas: map[_derrotasColumn] as String,
      golsFeitos: map[_golsFeitosColumn] as String,
      golsSofridos: map[_golsSofridosColumn] as String,
      saldoGols: map[_saldoGolsColumn] as String,
      classificacaoName: map[_classificacaoNameColumn] as String,
      classificacaoIndex: map[_classificacaoIndexColumn] as int,
    );
  }

  static const _idColumn = "id";
  static const _posicaoColumn = "posicao";
  static const _nomeTimeColumn = "nomeTime";
  static const _escudoTimeColumn = "escudoTime";
  static const _pontosColumn = "pontos";
  static const _jogosColumn = "jogos";
  static const _vitoriasColumn = "vitorias";
  static const _empatesColumn = "empates";
  static const _derrotasColumn = "derrotas";
  static const _golsFeitosColumn = "golsFeitos";
  static const _golsSofridosColumn = "golsSofridos";
  static const _saldoGolsColumn = "saldoGols";
  static const _classificacaoNameColumn = "classificacaoName";
  static const _classificacaoIndexColumn = "classificacaoIndex";

  static const tableName = "posicao";
  static const tableCreationStatement = """
  CREATE TABLE $tableName(
    $_idColumn VARCHAR(255) PRIMARY KEY, 
    $_posicaoColumn VARCHAR(255), 
    $_nomeTimeColumn VARCHAR(255), 
    $_escudoTimeColumn TEXT,
    $_pontosColumn VARCHAR(255), 
    $_jogosColumn VARCHAR(255), 
    $_vitoriasColumn VARCHAR(255), 
    $_empatesColumn VARCHAR(255), 
    $_derrotasColumn VARCHAR(255), 
    $_golsFeitosColumn VARCHAR(255), 
    $_golsSofridosColumn VARCHAR(255), 
    $_saldoGolsColumn VARCHAR(255), 
    $_classificacaoNameColumn VARCHAR(255), 
    $_classificacaoIndexColumn INT(11))
  """;
}
