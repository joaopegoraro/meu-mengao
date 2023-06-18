import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_mengao/data/api/api_service.dart';
import 'package:meu_mengao/data/database/entities/campeonato_entity.dart';
import 'package:meu_mengao/data/database/entities/partida_entity.dart';
import 'package:meu_mengao/data/database/entities/posicao_entity.dart';
import 'package:meu_mengao/data/database/meumengao_database.dart';
import 'package:meu_mengao/data/models/campeonato.dart';
import 'package:sqflite/sqflite.dart';

abstract class CampeonatosRepository {
  Future<Campeonato?> get(String id);

  Future<List<Campeonato>> getAll();
}

class CampeonatosRepositoryImpl extends CampeonatosRepository {
  CampeonatosRepositoryImpl(this._api);
  final ApiService _api;

  Future<Database> get _database async => MeuMengaoDatabase.instance;

  @override
  Future<Campeonato?> get(String id) async {
    try {
      final db = await _database;
      final savedCampeonatoMap = await db.query(
        CampeonatoEntity.tableName,
        where: "${CampeonatoEntity.idColumn} = ?",
        whereArgs: [id],
      );
      final savedCampeonato = savedCampeonatoMap.map((e) => CampeonatoEntity.fromMap(e).toCampeonato()).firstOrNull;
      return savedCampeonato;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  @override
  Future<List<Campeonato>> getAll() async {
    final receivedCampeonatos = await _api.getCampeonatos() ?? [];
    try {
      final db = await _database;

      for (var campeonato in receivedCampeonatos) {
        final savedCampeonatoMap = await db.query(
          CampeonatoEntity.tableName,
          where: "${CampeonatoEntity.idColumn} = ?",
          whereArgs: [campeonato.id],
        );
        final savedCampeonato = savedCampeonatoMap.map((e) => CampeonatoEntity.fromMap(e)).firstOrNull;

        if (savedCampeonato != null &&
            savedCampeonato.ano != null &&
            campeonato.ano.compareTo(savedCampeonato.ano!) > 0) {
          await db.delete(
            PosicaoEntity.tableName,
            where: "${PosicaoEntity.campeonatoIdColumn} = ?",
            whereArgs: [campeonato.id],
          );
          await db.delete(
            PartidaEntity.tableName,
            where: "${PartidaEntity.campeonatoIdColumn} = ?",
            whereArgs: [campeonato.id],
          );
        }

        await db.insert(
          CampeonatoEntity.tableName,
          CampeonatoEntity.fromCampeonato(campeonato).toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

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

final campeonatosRepositoryProvider = Provider<CampeonatosRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return CampeonatosRepositoryImpl(apiService);
});
