import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_verse/control/auth.dart';
import 'package:link_verse/models/bookmark.dart';

Future<void> addBookmarkLike(Bookmark bookmark) async {
  final user = getCurrentUser();
  if (user == null) return;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('bookmarks')
      .doc(bookmark.id).set({});
  await FirebaseFirestore.instance
      .collection('bookmarks')
      .doc(bookmark.id)
      .update({'likes': FieldValue.increment(1)});
}


Future<List<Bookmark>> getLikedBookmarks() async {
  final user = getCurrentUser();
  if (user == null) return [];
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('bookmarks')
      .get();
  final bookmarks = <Bookmark>[];
  for (final doc in snapshot.docs) {
    final bookmark = await FirebaseFirestore.instance
        .collection('bookmarks')
        .doc(doc.id)
        .get();
    bookmarks.add(Bookmark.fromJson(doc.id, bookmark.data()!));
  }
  return bookmarks;
}

Future<bool> isBookmarkLiked(Bookmark bookmark) async {
  final user = getCurrentUser();
  if (user == null) return false;
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('bookmarks')
      .doc(bookmark.id)
      .get();
  return snapshot.exists;
}

Future<void> removeBookmarkLike(Bookmark bookmark) async {
  final user = getCurrentUser();
  if (user == null) return;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('bookmarks')
      .doc(bookmark.id)
      .delete();
  await FirebaseFirestore.instance
      .collection('bookmarks')
      .doc(bookmark.id)
      .update({'likes': FieldValue.increment(-1)});
}