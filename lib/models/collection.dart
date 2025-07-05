class Collection {
  String id;
  String name;
  String description;
  String imageUrl;
  int noItems;

  Collection({
    this.id = '',
    this.name = '',
    this.description = '',
    this.imageUrl = '',
    this.noItems = 0,
  });

  
  factory Collection.fromJson(String id, Map<String, dynamic> json) {
    return Collection(
      id: id,
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      noItems: json['noItems'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'noItems': noItems,
    };
  }
}

List<Collection> createCollections() {
  return [
    Collection(
      id: '12345',
      name: 'My Collection',
      description: 'This is a sample collection description.',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/09/08/04/12/programmer-1653351_1280.png',
      noItems: 10,
    ),
    Collection(
      id: '67890',
      name: 'Another Collection',
      description: 'This is another sample collection description.',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/09/08/04/12/programmer-1653351_1280.png',
      noItems: 5,
    ),
    Collection(
      id: '54321',
      name: 'Third Collection',
      description: 'This is yet another sample collection description.',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/09/08/04/12/programmer-1653351_1280.png',
      noItems: 15,
    ),
  ];
}

Collection createCollection() {
  return Collection(
    id: '12345',
    name: 'My Collection',
    description: 'This is a sample collection description.',
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/09/08/04/12/programmer-1653351_1280.png',
    noItems: 10,
  );
}
