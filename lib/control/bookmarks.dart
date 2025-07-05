import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_verse/control/auth.dart';
import 'package:link_verse/models/bookmark.dart';
import 'package:link_verse/models/collection.dart';
import 'package:link_verse/models/comment.dart';
import 'package:link_verse/models/user.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> createBookmarkDoc(Bookmark bookmark) async {
  await FirebaseFirestore.instance
      .collection('bookmarks')
      .add(bookmark.toJson());
  await FirebaseFirestore.instance
      .collection('collections')
      .doc(bookmark.collection!.id)
      .update({'noItems': FieldValue.increment(1)});
}

Future<List<Bookmark>> getBookmarks(Collection collection) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('bookmarks')
      .where('collection', isEqualTo: collection.id)
      .get();
  return snapshot.docs
      .map((doc) => Bookmark.fromJson(doc.id, doc.data()))
      .toList();
}

Future<List<Comment>> getBookmarkComments(Bookmark bookmark) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('bookmarks')
      .doc(bookmark.id)
      .collection('comments')
      .get();
  return snapshot.docs.map((doc) => Comment.fromJson(doc.data())).toList();
}

Future<void> addBookmarkComment(Bookmark bookmark, Comment comment) async {
  final user = getCurrentUser();
  if (user == null) return;
  final userDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .get();
  comment.user = User.fromJson(userDoc.id, userDoc.data()!);
  await FirebaseFirestore.instance
      .collection('bookmarks')
      .doc(bookmark.id)
      .collection('comments')
      .add(comment.toJson());
  await FirebaseFirestore.instance
      .collection('bookmarks')
      .doc(bookmark.id)
      .update({'noComments': FieldValue.increment(1)});
}


Future<String> openBookmark(Bookmark bookmark) async {
  final Uri uri = Uri.parse(bookmark.url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
    return "Bookmark opened";
  } else {
    return "Could not open bookmark";
  }
}