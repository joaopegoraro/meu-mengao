import 'package:meu_mengao/data/database/entities/campeonato_entity.dart';
import 'package:meu_mengao/data/database/entities/noticia_entity.dart';
import 'package:meu_mengao/data/database/entities/partida_entity.dart';
import 'package:meu_mengao/data/database/entities/posicao_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MeuMengaoDatabase {
  Database? _db;

  Future<Database> get instance async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, "meu_mengao.db"),
      version: 1,
      onCreate: (db, version) {
        db.execute(CampeonatoEntity.tableCreationStatement);
        db.execute(NoticiaEntity.tableCreationStatement);
        db.execute(PartidaEntity.tableCreationStatement);
        db.execute(PosicaoEntity.tableCreationStatement);
      },
    );
  }
}
