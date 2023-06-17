import 'package:meu_mengao/data/api/api_service.dart';
import 'package:meu_mengao/data/database/entities/posicao_entity.dart';
import 'package:meu_mengao/data/database/meumengao_database.dart';
import 'package:meu_mengao/data/models/posicao.dart';
import 'package:sqflite/sqflite.dart';

class ClassificacaoRepository {
  final ApiService _api = ApiService();
  Future<Database> get _database async => MeuMengaoDatabase.instance;

  Future<List<Posicao>> getWithCampeonatoId(String campeonatoId) async {
    final receivedClassificacao = await _api.getClassificacao(campeonatoId) ?? [];
    try {
      final db = await _database;
      final batch = db.batch();

      for (var posicao in receivedClassificacao) {
        batch.insert(
          PosicaoEntity.tableName,
          PosicaoEntity.fromPosicao(posicao).toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);

      final savedClassificacaoMap = await db.query(PosicaoEntity.tableName);
      final savedClassificacao = savedClassificacaoMap.map((e) => PosicaoEntity.fromMap(e).toPosicao());

      if (savedClassificacao.isEmpty) {
        return receivedClassificacao;
      }

      return savedClassificacao.toList();
    } catch (e) {
      return receivedClassificacao;
    }
  }
}
