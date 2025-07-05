class User {
  String id;
  String name;
  String email;
  String? avatar;
  List<String> favoriteTags;

  User({
    this.id = '',
    this.name = '',
    this.email = '',
    this.avatar,
    this.favoriteTags = const [],
  });

  factory User.fromJson(String id, Map<String, dynamic> json) {
    return User(
      id: id,
      name: json['name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String?,
      favoriteTags: List<String>.from(json['favoriteTags'] ?? []),
    );
  }

}

User createUser() {
  return User(
    id: '12345',
    name: 'John Doe',
    email: 'john@example.com',
    avatar:
        'https://cdn.pixabay.com/photo/2017/11/10/05/46/user-2935524_1280.png',
    favoriteTags: ['Flutter', 'Dart', 'Programming'],
  );
}
