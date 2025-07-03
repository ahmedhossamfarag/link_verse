import 'package:flutter/material.dart';
import 'package:link_verse/models/bookmark.dart';
import 'package:link_verse/views/components/button.dart';
import 'package:link_verse/views/components/loading.dart';
import 'package:link_verse/views/components/text.dart';
import 'package:link_verse/views/components/text_field.dart';

class NewBookmark2View extends StatefulWidget {
  final Bookmark bookmark;
  const NewBookmark2View({super.key, required this.bookmark});

  @override
  State<StatefulWidget> createState() {
    return _NewBookmark2ViewState();
  }
}

class _NewBookmark2ViewState extends State<NewBookmark2View> {
  Bookmark? bookmark;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // bookmark = widget.bookmark;
    bookmark = createBookmark();
  }

  void _changeSummary(String value) {}

  void _addTag() {
    // Handle tag addition logic here
  }

  void _addImage() {
    // Handle image addition logic here
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle form submission logic here
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
        child: bookmark == null
            ? XLoading()
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      XTextField(
                        onChanged: _changeSummary,
                        placeholder: 'Summary',
                        maxLines: 10,
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          XHeadingText('Images'),
                          IconButton(
                            onPressed: _addImage,
                            icon: Icon(Icons.add, color: Colors.white),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white54),
                      const SizedBox(height: 8.0),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: bookmark!.imageUrls.map((image) {
                          return Stack(
                            children: [
                              Image.network(
                                image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: _removeImage(image),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          XHeadingText('Tags'),
                          IconButton(
                            onPressed: _addTag,
                            icon: Icon(Icons.add, color: Colors.white),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white54),
                      const SizedBox(height: 8.0),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: bookmark!.tags.map((tag) {
                          return Chip(
                            label: Text(tag),
                            onDeleted: _deleteTag(tag),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 100.0),
                      XButton(
                        onPressed: _submitForm,
                        child: const Text('Save Bookmark'),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Function() _removeImage(String image) {
    return () {
      setState(() {
        bookmark?.imageUrls.remove(image);
      });
    };
  }

  Function() _deleteTag(String tag) {
    return () {
      setState(() {
        bookmark?.tags.remove(tag);
      });
    };
  }
}
