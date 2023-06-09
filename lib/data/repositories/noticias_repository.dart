import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_mengao/data/api/api_service.dart';
import 'package:meu_mengao/data/database/entities/noticia_entity.dart';
import 'package:meu_mengao/data/database/meumengao_database.dart';
import 'package:meu_mengao/data/models/noticia.dart';
import 'package:sqflite/sqflite.dart';

abstract class NoticiasRepository {
  Future<List<Noticia>> getAll();
}

class NoticiasRepositoryImpl extends NoticiasRepository {
  NoticiasRepositoryImpl(this._api);
  final ApiService _api;

  Future<Database> get _database async => MeuMengaoDatabase.instance;

  @override
  Future<List<Noticia>> getAll() async {
    final receivedNoticias = await _api.getNoticias() ?? [];
    try {
      final db = await _database;
      final batch = db.batch();

      if (receivedNoticias.isNotEmpty) {
        await db.delete(NoticiaEntity.tableName);
        for (var noticia in receivedNoticias) {
          batch.insert(
            NoticiaEntity.tableName,
            NoticiaEntity.fromNoticia(noticia).toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }

        await batch.commit(noResult: true);

        return receivedNoticias;
      }

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
      if (kDebugMode) {
        print(e);
      }
      return receivedNoticias;
    }
  }
}

final noticiasRepositoryProvider = Provider<NoticiasRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return NoticiasRepositoryImpl(apiService);
});
