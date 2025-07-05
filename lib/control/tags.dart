import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> getTags() async {
  final snapshot = await FirebaseFirestore.instance.collection('tags').doc('default').get();
  return List<String>.from(snapshot.data()!['values'] ?? []);
}

Future<void> addTags(List<String> tags) async {
  try{
    await FirebaseFirestore.instance.collection('tags').doc('default').update({'values': FieldValue.arrayUnion(tags)});
  }catch(_){
    await FirebaseFirestore.instance.collection('tags').doc('default').set({'values': tags});
  }
}