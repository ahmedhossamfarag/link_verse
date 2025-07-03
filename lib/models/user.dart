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
