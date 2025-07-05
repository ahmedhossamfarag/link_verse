import 'package:link_verse/models/collection.dart';
import 'package:link_verse/models/comment.dart';
import 'package:link_verse/models/user.dart';

class Bookmark {
  String id;
  String title;
  String description;
  String url;
  String imageUrl;
  List<String> tags;
  List<String> imageUrls;
  String summary;
  int noLikes;
  int noComments;
  List<Comment> comments;
  Collection? collection;
  User? user;
  DateTime? createdAt;

  Bookmark({
    this.id = '',
    this.title = '',
    this.description = '',
    this.url = '',
    this.imageUrl = '',
    this.tags = const [],
    this.imageUrls = const [],
    this.summary = '',
    this.noLikes = 0,
    this.noComments = 0,
    this.comments = const [],
    this.collection,
    this.user,
    this.createdAt,
  }){
    createdAt ??= DateTime.now();
  }

  factory Bookmark.fromJson(String id, Map<String, dynamic> json) {
    return Bookmark(
      id: id,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      summary: json['summary'] ?? '',
      noLikes: json['noLikes'] ?? 0,
      noComments: json['noComments'] ?? 0,
      collection: Collection(id: json['collection'] ?? ''),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'imageUrl': imageUrl,
      'tags': tags,
      'imageUrls': imageUrls,
      'summary': summary,
      'noLikes': noLikes,
      'noComments': noComments,
      'collection': collection?.id,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
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
        'https://cdn.pixabay.com/photo/2023/07/04/19/43/man-8106958_1280.png',
      ],
      summary: 'This is a sample summary of the bookmark.',
      collection: collection,
      user: user,
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
        'https://cdn.pixabay.com/photo/2023/07/04/19/43/man-8106958_1280.png',
      ],
      summary: 'This is another sample summary of the bookmark.',
      collection: collection,
      user: user,
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
      'https://cdn.pixabay.com/photo/2023/07/04/19/43/man-8106958_1280.png',
    ],
    summary: 'This is a sample summary of the bookmark.',
    comments: createComments(),
    collection: createCollection(),
    user: createUser(),
  );
}
