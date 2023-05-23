import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:meu_mengao/data/models/site.dart';

abstract class SitesRepository {
  Future<List<Site>> getSites();
  Future<Site?> getSiteWithId(String id);
}

class SitesRepositoryImpl extends SitesRepository {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  static const _sitesCollectionId = "sites";

  @override
  Future<List<Site>> getSites() async {
    final snapshot = await firestore
        .collection(_sitesCollectionId)
        .withConverter(
          fromFirestore: (snapshot, _) {
            final document = snapshot.data();
            if (document == null) return null;
            return Site.fromMap(snapshot.data() ?? {});
          },
          toFirestore: (site, _) => site?.toMap() as Map<String, Object?>,
        )
        .get();
    final sites = snapshot.docs.map((siteSnapshot) => siteSnapshot.data()).whereNotNull().toList();
    return sites;
  }

  @override
  Future<Site?> getSiteWithId(String id) async {
    final snapshot = await firestore
        .collection(_sitesCollectionId)
        .doc(id)
        .withConverter(
          fromFirestore: (snapshot, _) {
            final document = snapshot.data();
            if (document == null) return null;
            return Site.fromMap(snapshot.data() ?? {});
          },
          toFirestore: (site, _) => site?.toMap() as Map<String, Object?>,
        )
        .get();
    return snapshot.data();
  }
}
