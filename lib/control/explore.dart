import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_verse/control/bookmarks.dart';
import 'package:link_verse/control/profile.dart';
import 'package:link_verse/control/search.dart';
import 'package:link_verse/models/bookmark.dart';

Future<List<Bookmark>> getExploreBookmarks() async {
  final tags = await getUserTags();
  final results = await algoliaSearchTags(tags);
  final bookmarks = <Bookmark>[];
  for (final result in results) {
    final bookmark = await getBookmark(result.id);
    bookmarks.add(bookmark);
  }
  if (bookmarks.length < 10) {
    final results = await FirebaseFirestore.instance.collection('bookmarks').orderBy('createdAt', descending: true).limit(10).get();
    for (final result in results.docs) {
      if (bookmarks.any((b) => b.id == result.id)) continue;
      final bookmark = Bookmark.fromJson(result.id, result.data());
      bookmarks.add(bookmark);
    }
  }
  return bookmarks;
}