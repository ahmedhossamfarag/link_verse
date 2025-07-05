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
    callback(User.fromJson(snapshot.id, snapshot.data() ?? {}));
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

Future<void> updateUserAvatar(String avatar) async {
  final user = getCurrentUser();
  if (user != null) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({'avatar': avatar});
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

Future<List<String>> getUserTags() async {
  final user = getCurrentUser();
  if (user != null) {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    return List<String>.from(snapshot.data()?['favoriteTags'] ?? []);
  }
  return [];
}

Future<void> addToUserHistory(String query) async {
  final user = getCurrentUser();
  if (user != null) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({'history': FieldValue.arrayUnion([query])});
  }
}

Future<List<String>> getUserHistory() async {
  final user = getCurrentUser();
  if (user != null) {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    return List<String>.from(snapshot.data()?['history'] ?? []);
  }
  return [];
}