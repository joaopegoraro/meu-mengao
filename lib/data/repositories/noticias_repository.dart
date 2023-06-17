import 'package:meu_mengao/data/api/api_service.dart';
import 'package:meu_mengao/data/database/entities/noticia_entity.dart';
import 'package:meu_mengao/data/database/meumengao_database.dart';
import 'package:meu_mengao/data/models/noticia.dart';
import 'package:sqflite/sqflite.dart';

class NoticiasRepository {
  final ApiService _api = ApiService();
  Future<Database> get _database async => MeuMengaoDatabase.instance;

  Future<List<Noticia>> getAll() async {
    final receivedNoticias = await _api.getNoticias() ?? [];
    try {
      final db = await _database;
      final batch = db.batch();

      for (var noticia in receivedNoticias) {
        batch.insert(
          NoticiaEntity.tableName,
          NoticiaEntity.fromNoticia(noticia).toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);

      final savedNoticiasMap = await db.query(
        NoticiaEntity.tableName,
        orderBy: "${NoticiaEntity.dataColumn} DESC",
      );
      final savedNoticias = savedNoticiasMap.map((e) => NoticiaEntity.fromMap(e).toNoticia());

      if (savedNoticias.isEmpty) {
        return receivedNoticias;
      }

      return savedNoticias.toList();
    } catch (e) {
      return receivedNoticias;
    }
  }
}
