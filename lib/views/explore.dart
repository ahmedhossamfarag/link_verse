import 'package:flutter/material.dart';
import 'package:link_verse/models/bookmark.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExploreViewState();
  }
}

class _ExploreViewState extends State<ExploreView> {
  List<Bookmark> bookmarks = [];

  @override
  void initState() {
    super.initState();
    // Initialize bookmarks or fetch from a service
    bookmarks = createBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: bookmarks.map((bookmark) => BookmarkView(bookmark)).toList(),
      ),
    );
  }
}

class BookmarkView extends StatelessWidget {
  final Bookmark bookmark;

  const BookmarkView(this.bookmark, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: const Color(0xFF0C4D5E),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  bookmark.imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookmark.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      bookmark.description,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite, size: 10, color: Colors.white),
                        Text(
                          bookmark.noLikes.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.comment, size: 10, color: Colors.white),
                        Text(
                          bookmark.noComments.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookmark.summary,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    bookmark.imageUrls.isNotEmpty
                        ? bookmark.imageUrls[0]
                        : bookmark.imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
