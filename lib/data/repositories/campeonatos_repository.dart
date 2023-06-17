import 'package:meu_mengao/data/api/api_service.dart';
import 'package:meu_mengao/data/database/entities/campeonato_entity.dart';
import 'package:meu_mengao/data/database/meumengao_database.dart';
import 'package:meu_mengao/data/models/campeonato.dart';
import 'package:sqflite/sqflite.dart';

class CampeonatosRepository {
  final ApiService _api = ApiService();
  Future<Database> get _database async => MeuMengaoDatabase.instance;

  Future<List<Campeonato>> getAll() async {
    final receivedCampeonatos = await _api.getCampeonatos();

    final db = await _database;
    final batch = db.batch();

    receivedCampeonatos?.forEach((campeonato) {
      batch.insert(CampeonatoEntity.tableName, CampeonatoEntity.fromCampeonato(campeonato).toMap());
    });

    await batch.commit(noResult: true);

    final savedCampeonatosMap = await db.query(CampeonatoEntity.tableName);
    final savedCampeonatos = savedCampeonatosMap.map((e) => CampeonatoEntity.fromMap(e).toCampeonato());

    return savedCampeonatos.toList();
  }
}
