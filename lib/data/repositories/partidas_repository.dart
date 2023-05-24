import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:meu_mengao/data/models/partida.dart';

abstract class PartidasRepository {
  Future<List<Partida>> getPartidas();
  Future<Partida?> getProximaPartida();
}

class PartidasRepositoryImpl extends PartidasRepository {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  static const _partidasCollectionId = "partidas";

  @override
  Future<List<Partida>> getPartidas() async {
    final snapshot = await firestore
        .collection(_partidasCollectionId)
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .get();
    final partidas = snapshot.docs
        .map((partidaSnapshot) => partidaSnapshot.data())
        .whereNotNull()
        .where((partida) => !partida.isCorrupted)
        .toList();
    return partidas;
  }

  @override
  Future<Partida?> getProximaPartida() async {
    final now = DateTime.now();
    final dateFormatted = DateFormat("yyyy-MM-ddTHH:mm:ssZ").format(now);
    final snapshot = await firestore
        .collection(_partidasCollectionId)
        .where("data", isGreaterThanOrEqualTo: dateFormatted)
        .orderBy("data", descending: true)
        .limit(1)
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .get();
    final partida = snapshot.docs.firstOrNull?.data();
    if (partida?.isCorrupted != false) return null;
    return partida;
  }

  Partida? _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final document = snapshot.data();
    if (document == null) return null;
    document["id"] = snapshot.id;
    return Partida.fromMap(document);
  }

  Map<String, Object?> _toFirestore(Partida? partida, SetOptions? options) {
    return partida?.toMap() as Map<String, Object?>;
  }
}
