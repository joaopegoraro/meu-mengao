import 'package:flutter/foundation.dart';
import 'package:meu_mengao/data/api/api_service.dart';
import 'package:meu_mengao/data/database/entities/campeonato_entity.dart';
import 'package:meu_mengao/data/database/meumengao_database.dart';
import 'package:meu_mengao/data/models/campeonato.dart';
import 'package:sqflite/sqflite.dart';

class CampeonatosRepository {
  final ApiService _api = ApiService();
  Future<Database> get _database async => MeuMengaoDatabase.instance;

  Future<List<Campeonato>> getAll() async {
    final receivedCampeonatos = await _api.getCampeonatos() ?? [];
    try {
      final db = await _database;
      final batch = db.batch();

      for (var campeonato in receivedCampeonatos) {
        batch.insert(
          CampeonatoEntity.tableName,
          CampeonatoEntity.fromCampeonato(campeonato).toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);

      final savedCampeonatosMap = await db.query(CampeonatoEntity.tableName);
      final savedCampeonatos = savedCampeonatosMap.map((e) => CampeonatoEntity.fromMap(e).toCampeonato());

      if (savedCampeonatos.isEmpty) {
        return receivedCampeonatos;
      }

      return savedCampeonatos.toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return receivedCampeonatos;
    }
  }
}
