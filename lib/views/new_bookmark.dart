import 'package:flutter/material.dart';
import 'package:link_verse/control/profile.dart';
import 'package:link_verse/control/validators.dart';
import 'package:link_verse/models/bookmark.dart';
import 'package:link_verse/models/collection.dart';
import 'package:link_verse/views/components/button.dart';
import 'package:link_verse/views/components/text_field.dart';
import 'package:link_verse/views/new_bookmark_2.dart';

class NewBookmarkView extends StatefulWidget {
  final Collection collection;
  const NewBookmarkView({super.key, required this.collection});

  @override
  State<StatefulWidget> createState() {
    return _NewBookmarkViewState();
  }
}

class _NewBookmarkViewState extends State<NewBookmarkView> {
  late Bookmark bookmark;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    bookmark = Bookmark(collection: widget.collection);
    getCurrentUserProfile((user) => bookmark.user = user);
  }

  void _changeTitle(String value) {
    bookmark.title = value;
  }

  void _changeDescription(String value) {
    bookmark.description = value;
  }

  void _changeUrl(String value) {
    bookmark.url = value;
  }

  void _changeImageUrl(String value) {
    bookmark.imageUrl = value;
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => NewBookmark2View(bookmark: bookmark)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4999B6),
      appBar: AppBar(
        title: const Text('New Bookmark'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              XTextField(
                onChanged: _changeTitle,
                placeholder: 'Title',
                prefixIcon: Icons.title,
                validator: titleValidator,
              ),
              const SizedBox(height: 16.0),
              XTextField(
                onChanged: _changeDescription,
                placeholder: 'Description',
                prefixIcon: Icons.description,
                validator: descriptionValidator,
                maxLines: 3,
              ),
              const SizedBox(height: 16.0),
              XTextField(
                onChanged: _changeUrl,
                placeholder: 'URL',
                prefixIcon: Icons.link,
                validator: uRlValidator,
              ),
              const SizedBox(height: 16.0),
              XTextField(
                onChanged: _changeImageUrl,
                placeholder: 'Image URL',
                prefixIcon: Icons.image,
                validator: uRlValidator,
              ),
              const Expanded(child: SizedBox()),
              XButton(onPressed: _submitForm, child: const Text('Continue')),
            ],
          ),
        ),
      ),
    );
  }
}
