import 'package:algolia/algolia.dart';
import 'package:link_verse/models/bookmark.dart';

class Application {
    static final Algolia algolia = Algolia.init(
      applicationId: '9WP6Y7G76X',
      apiKey: '70c465c21599fcf76c37876cc60264f3',
    );
}


Future<void> algoliaSaveBookmark(Bookmark bookmark) async {
  await Application.algolia.instance.index('link_verse_bookmarks').addObject({
    'objectID': bookmark.id,
    'title': bookmark.title,
    'description': bookmark.description,
    'imageUrl': bookmark.imageUrl,
    '_tags': bookmark.tags,
    'tagsText': bookmark.tags.join(', '),
  });
}

Future<List<Bookmark>> algoliaSearchQuery(String query) async {
  final results = await Application.algolia.instance
      .index('link_verse_bookmarks')
      .query(query).getObjects();
  return results.hits.map((hit) => Bookmark.fromJson(hit.objectID, hit.data)).toList();
}

Future<List<Bookmark>> algoliaSearchTags(List<String> tags) async {
  var index = Application.algolia.instance
      .index('link_verse_bookmarks').filters(tags.map((tag) => "'$tag'").join(' OR ')).setHitsPerPage(10);
  final results = await index.getObjects();
  return results.hits.map((hit) => Bookmark.fromJson(hit.objectID, hit.data)).toList();
}
