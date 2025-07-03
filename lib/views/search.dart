import 'package:flutter/material.dart';
import 'package:link_verse/views/components/text.dart';
import 'package:link_verse/views/components/text_field.dart';

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
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    history = [
      'flutter',
      'dart',
      'programming',
      'mobile development',
      'web development',
      'machine learning',
      'artificial intelligence',
      'data science',
    ];

    tags = [
      'flutter',
      'dart',
      'programming',
      'mobile development',
      'web development',
      'machine learning',
      'artificial intelligence',
      'data science',
    ];
  }

  void _onQueryChanged(String query) {
    setState(() {
      this.query = query;
    });
  }

  void Function() _setQuery(String item) {
    return () {
      _searchController.text = item;
      setState(() {
        query = item;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            XHeadingText('Popular Tags'),
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
        ],
      ),
    );
  }
}
