import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:meu_mengao/data/models/noticia.dart';

abstract class NoticiasRepository {
  Future<List<Noticia>> getNoticias();
}

class NoticiasRepositoryImpl extends NoticiasRepository {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @override
  Future<List<Noticia>> getNoticias() async {
    final snapshot = await firestore
        .collection("noticias")
        .withConverter(
          fromFirestore: (snapshot, _) {
            final document = snapshot.data();
            if (document == null) return null;
            return Noticia.fromMap(snapshot.data() ?? {});
          },
          toFirestore: (noticia, _) => noticia?.toMap() as Map<String, Object?>,
        )
        .get();
    final noticias = snapshot.docs.map((noticiaSnapshot) => noticiaSnapshot.data()).whereNotNull().toList();
    return noticias;
  }
}
