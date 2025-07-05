import 'package:link_verse/models/user.dart';

class Comment {
  String content;
  User? user;
  DateTime? createdAt;

  Comment({
    this.content = '',
    this.user,
    this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    content: json['content'],
    user: User(name: json['userName'], avatar: json['userAvatar']),
    createdAt: DateTime.parse(json['createdAt']),
  );

  Map<String, dynamic> toJson() => {
    'content': content,
    'userName': user!.name,
    'userAvatar': user!.avatar,
    'createdAt': createdAt!.toIso8601String(),
  };

}

List<Comment> createComments() {
  var user = createUser();
  return [
    Comment(
      content: 'This is a sample comment.',
      user: user,
      createdAt: DateTime.now(),
    ),
    Comment(
      content: 'Another comment for testing.',
      user: user,
      createdAt: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];
}