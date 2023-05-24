import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:meu_mengao/data/models/campeonato.dart';
import 'package:meu_mengao/data/models/partida.dart';
import 'package:meu_mengao/data/models/time.dart';

abstract class CampeonatoRepository {
  Future<List<Campeonato>> getCampeonatos();
  Future<Campeonato?> getCampeonatoWithId(String id);
}

class CampeonatoRepositoryImpl extends CampeonatoRepository {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  static const _campeonatosCollectionId = "partidas";

  @override
  Future<List<Campeonato>> getCampeonatos() async {
    final snapshot = await firestore
        .collection(_campeonatosCollectionId)
        .withConverter(fromFirestore: _campeonatofromFirestore, toFirestore: (_, __) => {})
        .get();
    final campeonatos = snapshot.docs
        .map((campeonatoSnapshot) => campeonatoSnapshot.data())
        .whereNotNull()
        .where((campeonato) => !campeonato.isCorrupted)
        .toList();
    return campeonatos;
  }

  @override
  Future<Campeonato?> getCampeonatoWithId(String id) async {
    final mataMataSnapshot = await firestore
        .collection(_campeonatosCollectionId)
        .doc(id)
        .collection("mataMata")
        .withConverter(fromFirestore: _mataMatafromFirestore, toFirestore: (_, __) => {})
        .get();
    final mataMata = mataMataSnapshot.docs
        .map((partidaSnapshot) => partidaSnapshot.data())
        .whereNotNull()
        .where((partida) => !partida.isCorrupted)
        .toList();

    final classificacaoSnapshot = await firestore
        .collection(_campeonatosCollectionId)
        .doc(id)
        .collection("grupo")
        .withConverter(fromFirestore: _classificacaofromFirestore, toFirestore: (_, __) => {})
        .get();
    final classificacao = classificacaoSnapshot.docs
        .map((timeSnapshot) => timeSnapshot.data())
        .whereNotNull()
        .where((time) => !time.isCorrupted)
        .toList();

    return Campeonato(
      id: id,
      nome: "",
      classificacao: classificacao,
      mataMata: mataMata,
    );
  }

  Campeonato? _campeonatofromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final document = snapshot.data();
    if (document == null) return null;
    document["id"] = snapshot.id;
    return Campeonato.fromMap(document);
  }

  Partida? _mataMatafromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final document = snapshot.data();
    if (document == null) return null;
    document["id"] = snapshot.id;
    return Partida.fromMap(document);
  }

  Time? _classificacaofromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final document = snapshot.data();
    if (document == null) return null;
    document["id"] = snapshot.id;
    return Time.fromMap(document);
  }
}
