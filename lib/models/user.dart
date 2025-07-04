class User {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final List<String> favoriteTags;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.favoriteTags = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String?,
      favoriteTags: List<String>.from(json['favoriteTags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'favoriteTags': favoriteTags,
    };
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
