import 'package:flutter/material.dart';
import 'package:link_verse/control/bookmarks.dart';
import 'package:link_verse/control/profile.dart';
import 'package:link_verse/control/search.dart';
import 'package:link_verse/models/bookmark.dart';
import 'package:link_verse/views/bookmark.dart' as bookmark_view;
import 'package:link_verse/views/components/loading.dart';
import 'package:link_verse/views/components/no_content.dart';
import 'package:link_verse/views/components/text.dart';
import 'package:link_verse/views/components/text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SearchViewState();
  }
}

class _SearchViewState extends State<SearchView> {
  String query = '';
  List<String> history = [];
  List<String> tags = [];
  List<Bookmark>? bookmarks;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserHistory().then((value) => setState(() => history = value));
    getUserTags().then((value) => setState(() => tags = value));
  }

  void _onQueryChanged(String query) {
    setState(() {
      this.query = query;
    });
    algoliaSearchQuery(query).then((value) => setState(() => bookmarks = value));
  }

  void Function() _setQuery(String item) {
    return () {
      _searchController.text = item;
      _onQueryChanged(item);
    };
  }

  void _addQueryToHistory() {
    setState(() {
      history = [query, ...history];
    });
    addToUserHistory(query);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          XTextField(
            onChanged: _onQueryChanged,
            placeholder: 'Search...',
            prefixIcon: Icons.search,
            controller: _searchController,
          ),
          const SizedBox(height: 16),
          if (query.isEmpty) ...[
            XHeadingText('Your History'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: history
                  .map(
                    (item) => ElevatedButton(
                      onPressed: _setQuery(item),
                      child: Text(item),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 32),
            XHeadingText('Favorite Tags'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tags
                  .map(
                    (tag) => ElevatedButton(
                      onPressed: _setQuery(tag),
                      child: Text(tag),
                    ),
                  )
                  .toList(),
            ),
          ],
          if (query.isNotEmpty)
            bookmarks == null
                ? const XLoading()
                : bookmarks!.isEmpty
                ? XNoContent(image: 'assets/main/no-results.gif')
                : Column(
                    children: bookmarks!
                        .map((bookmark) => BookmarkView(bookmark, onOpen: _addQueryToHistory))
                        .toList(),
                  ),
        ],
      ),
    );
  }
}

class BookmarkView extends StatelessWidget {
  final Bookmark bookmark;
  final void Function() onOpen;
  const BookmarkView(this.bookmark, {super.key, required this.onOpen});

  void _openBookmark(BuildContext context, Bookmark bookmark) {
    onOpen();
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
        getBookmark(bookmark.id).then((value) => _openBookmark(context.mounted ? context : context, value));
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
                placeholder: (context, url) => const CircularProgressIndicator(),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

