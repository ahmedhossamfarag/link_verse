import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_verse/models/collection.dart';

Future<void> createCollectionDoc(Collection collection) async {
  await FirebaseFirestore.instance
      .collection('collections')
      .add(collection.toJson());
}

Future<List<Collection>> getCollections() async {
  final snapshot = await FirebaseFirestore.instance.collection('collections').get();
  return snapshot.docs.map((doc) => Collection.fromJson(doc.id, doc.data())).toList();
}