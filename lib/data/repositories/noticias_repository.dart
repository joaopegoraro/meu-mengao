import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:meu_mengao/data/models/noticia.dart';

abstract class NoticiasRepository {
  Future<List<Noticia>> getNoticias();
}

class NoticiasRepositoryImpl extends NoticiasRepository {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  static const _noticiasCollectionId = "noticias";

  @override
  Future<List<Noticia>> getNoticias() async {
    final snapshot = await firestore
        .collection(_noticiasCollectionId)
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .get();
    final noticias = snapshot.docs
        .map((noticiaSnapshot) => noticiaSnapshot.data())
        .whereNotNull()
        .where((noticia) => !noticia.isCorrupted())
        .toList();
    return noticias;
  }

  Noticia? _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final document = snapshot.data();
    if (document == null) return null;
    document["id"] = snapshot.id;
    return Noticia.fromMap(document);
  }

  Map<String, Object?> _toFirestore(Noticia? noticia, SetOptions? options) {
    return noticia?.toMap() as Map<String, Object?>;
  }
}
