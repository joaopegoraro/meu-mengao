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
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .get();
    final sites = snapshot.docs
        .map((siteSnapshot) => siteSnapshot.data())
        .whereNotNull()
        .where((site) => !site.isCorrupted)
        .toList();
    return sites;
  }

  @override
  Future<Site?> getSiteWithId(String id) async {
    final snapshot = await firestore
        .collection(_sitesCollectionId)
        .doc(id)
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .get();
    final site = snapshot.data();
    if (site?.isCorrupted != false) return null;
    return snapshot.data();
  }

  Site? _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final document = snapshot.data();
    if (document == null) return null;
    document["id"] = snapshot.id;
    return Site.fromMap(document);
  }

  Map<String, Object?> _toFirestore(Site? site, SetOptions? options) {
    return site?.toMap() as Map<String, Object?>;
  }
}
