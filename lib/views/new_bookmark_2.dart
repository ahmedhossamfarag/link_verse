import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:link_verse/control/ai.dart';
import 'package:link_verse/control/bookmarks.dart';
import 'package:link_verse/control/validators.dart';
import 'package:link_verse/models/bookmark.dart';
import 'package:link_verse/views/bookmarks.dart';
import 'package:link_verse/views/components/button.dart';
import 'package:link_verse/views/components/loading.dart';
import 'package:link_verse/views/components/overlay_input.dart';
import 'package:link_verse/views/components/overlay_loading.dart';
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
  final TextEditingController _summaryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bookmark?.tags = [];
    bookmark?.imageUrls = [];
    inspectBookmark(widget.bookmark).then((value) {
      setState(() {
        bookmark = widget.bookmark;
      });
      _summaryController.text = bookmark?.summary ?? '';
    });
  }

  void _changeSummary(String value) {
    bookmark?.summary = value;
  }

  void _addTag() {
    XOverlayInput(
      context,
      placeholder: 'Tag',
      validator: (tag) => tagValidator(tag, bookmark?.tags ?? []),
      callback: (value) {
        setState(() {
          bookmark?.tags.add(value);
        });
      },
    );
  }

  void _addImage() {
    XOverlayInput(
      context,
      placeholder: 'Image URL',
      validator: (url) => imageValidator(url, bookmark?.imageUrls ?? []),
      callback: (value) {
        setState(() {
          bookmark?.imageUrls.add(value);
        });
      },
    );
  }

  void _exit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            BookmarksView(collection: (bookmark?.collection)!),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final loading = showLoadingOverlay(context);
      createBookmarkDoc(bookmark!).then((value) {
        loading.remove();
        _exit();
      });
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
                        validator: summaryValidator,
                        controller: _summaryController,
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
                              CachedNetworkImage(
                                imageUrl: image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
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
