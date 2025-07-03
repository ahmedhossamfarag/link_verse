import 'package:link_verse/models/collection.dart';
import 'package:link_verse/models/comment.dart';
import 'package:link_verse/models/user.dart';

class Bookmark {
  final String id;
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final List<String> tags;
  final List<String> imageUrls;
  final String summary;
  final int noLikes;
  final int noComments;
  final List<Comment> comments;
  final Collection collection;
  final User user;
  final DateTime createdAt;

  Bookmark({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.tags,
    required this.imageUrls,
    required this.summary,
    this.noLikes = 0,
    this.noComments = 0,
    this.comments = const [],
    required this.collection,
    required this.user,
    required this.createdAt,
  });
}

List<Bookmark> createBookmarks() {
  var user = createUser();
  var collection = createCollection();
  return [
    Bookmark(
      id: '12345',
      title: 'Sample Bookmark',
      description: 'This is a sample bookmark description.',
      url: 'https://example.com',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/09/08/04/12/programmer-1653351_1280.png',
      tags: ['sample', 'bookmark'],
      imageUrls: [
        'https://cdn.pixabay.com/photo/2016/09/08/04/12/programmer-1653351_1280.png',
        'https://cdn.pixabay.com/photo/2023/07/04/19/43/man-8106958_1280.png'
      ],
      summary: 'This is a sample summary of the bookmark.',
      collection: collection,
      user: user,
      createdAt: DateTime.now(),
    ),
    Bookmark(
      id: '67890',
      title: 'Another Bookmark',
      description: 'This is another sample bookmark description.',
      url: 'https://example2.com',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/09/08/04/12/programmer-1653351_1280.png',
      tags: ['another', 'bookmark'],
      imageUrls: [
        'https://cdn.pixabay.com/photo/2016/09/08/04/12/programmer-1653351_1280.png',
        'https://cdn.pixabay.com/photo/2023/07/04/19/43/man-8106958_1280.png'
      ],
      summary: 'This is another sample summary of the bookmark.',
      collection: collection,
      user: user,
      createdAt: DateTime.now(),
    ),
  ];
}

Bookmark createBookmark() {
  return Bookmark(
    id: '12345',
    title: 'Sample Bookmark',
    description: 'This is a sample bookmark description.',
    url: 'https://example.com',
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/09/08/04/12/programmer-1653351_1280.png',
    tags: ['sample', 'bookmark'],
    imageUrls: [
      'https://cdn.pixabay.com/photo/2016/09/08/04/12/programmer-1653351_1280.png',
      'https://cdn.pixabay.com/photo/2023/07/04/19/43/man-8106958_1280.png'
    ],
    summary: 'This is a sample summary of the bookmark.',
    noComments: 2,
    comments: createComments(),
    collection: createCollection(),
    user: createUser(),
    createdAt: DateTime.now(),
  );
}