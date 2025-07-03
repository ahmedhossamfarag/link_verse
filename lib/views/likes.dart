import 'package:flutter/material.dart';
import 'package:link_verse/models/bookmark.dart';

class LikesView extends StatefulWidget {
  final String title = "Favorites";
  const LikesView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LikesViewState();
  }
}

class _LikesViewState extends State<LikesView> {
  List<Bookmark> bookmarks = [];

  @override
  void initState() {
    super.initState();
    // Initialize bookmarks or fetch from a service
    bookmarks = createBookmarks();
  }

  void _onDeleteBookmark(Bookmark bookmark) {
    // Remove the bookmark from the list
    // In a real application, you might also want to remove it from a database or service
    setState(() {
      bookmarks.remove(bookmark);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: bookmarks
            .map((bookmark) => BookmarkView(bookmark, _onDeleteBookmark))
            .toList(),
      ),
    );
  }
}

class BookmarkView extends StatelessWidget {
  final Bookmark bookmark;
  final void Function(Bookmark) onDelete;

  const BookmarkView(this.bookmark, this.onDelete, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: const Color(0xFF0C4D5E),
      child: Row(
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
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Icon(Icons.comment, size: 10, color: Colors.white),
                    Text(
                      bookmark.noComments.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  onDelete(bookmark);
                },
                icon: Icon(Icons.delete, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
