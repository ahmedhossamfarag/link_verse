import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:link_verse/control/bookmarks.dart';
import 'package:link_verse/models/bookmark.dart';
import 'package:link_verse/models/collection.dart';
import 'package:link_verse/views/components/no_content.dart';
import 'package:link_verse/views/layouts/nav_layout.dart';
import 'package:link_verse/views/new_bookmark.dart';
import 'package:link_verse/views/bookmark.dart' as bookmark_view;

class BookmarksView extends StatefulWidget {
  final Collection collection;
  const BookmarksView({super.key, required this.collection});

  @override
  State<StatefulWidget> createState() {
    return _BookmarksViewState();
  }
}

class _BookmarksViewState extends State<BookmarksView> {
  List<Bookmark>? bookmarks;

  @override
  void initState() {
    super.initState();
    // Load bookmarks from storage or database
    getBookmarks(
      widget.collection,
    ).then((value) => setState(() => bookmarks = value));
  }

  void _addBookmark() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewBookmarkView(collection: widget.collection),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (bookmarks == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return NavLayout(
      key: UniqueKey(),
      selectedIndex: 0,
      title: "Bookmarks",
      actionIcon: Icons.add,
      actionHandler: _addBookmark,
      body: bookmarks!.isEmpty
          ? const XNoContent()
          : SingleChildScrollView(
              child: Column(
                children: bookmarks!
                    .map((bookmark) => BookmarkView(bookmark))
                    .toList(),
              ),
            ),
    );
  }
}

class BookmarkView extends StatelessWidget {
  final Bookmark bookmark;

  const BookmarkView(this.bookmark, {super.key});

  void _openBookmark(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => bookmark_view.BookmarkView(bookmark),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openBookmark(context);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: const Color(0xFF0C4D5E),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: bookmark.imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
      ),
    );
  }
}
