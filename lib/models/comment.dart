import 'package:link_verse/models/user.dart';

class Comment {
  final String id;
  final String content;
  final User user;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.content,
    required this.user,
    required this.createdAt,
  });
}

List<Comment> createComments() {
  var user = createUser();
  return [
    Comment(
      id: '1',
      content: 'This is a sample comment.',
      user: user,
      createdAt: DateTime.now(),
    ),
    Comment(
      id: '2',
      content: 'Another comment for testing.',
      user: user,
      createdAt: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];
}