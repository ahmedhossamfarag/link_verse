import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_verse/control/auth.dart';
import 'package:link_verse/models/user.dart';

Future<void> getCurrentUserProfile(Function(User) callback) async {
  final user = getCurrentUser();
  if (user != null) {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    callback(User.fromJson(snapshot.data()!));
  }
}


Future<void> updateUserName(String name) async {
  final user = getCurrentUser();
  if (user != null) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({'name': name});
  }
}


Future<void> updateUserTags(List<String> tags) async {
  final user = getCurrentUser();
  if (user != null) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({'favoriteTags': tags});
  }
}