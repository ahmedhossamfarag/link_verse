import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:link_verse/models/bookmark.dart';
import 'package:link_verse/models/comment.dart';
import 'package:link_verse/views/components/button.dart';
import 'package:link_verse/views/components/text.dart';
import 'package:link_verse/views/components/text_field.dart';

class BookmarkView extends StatelessWidget {
  final Bookmark bookmark;

  final _commentController = TextEditingController();

  BookmarkView(this.bookmark, {super.key});

  void _openBookmark() {}

  void _changeComment(String p1) {}

  void _addComment() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          color: Color(0xFF4999B6),
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
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 240, 236, 236),
                          ),
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
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    CarouselSlider(
                      items: bookmark.imageUrls
                          .map(
                            (image) => ClipRRect(
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
                          )
                          .toList(),
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(children: [XHeadingText('Tags')]),
                    Divider(color: Colors.white),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: bookmark.tags.map((tag) {
                        return Chip(
                          label: Text(tag),
                          backgroundColor: Color(0xFF41A0C3),
                          labelStyle: const TextStyle(color: Colors.white),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    Row(children: [XHeadingText('Comments')]),
                    Divider(color: Colors.white),
                    ...bookmark.comments.map((comment) => CommentView(comment)),
                    const SizedBox(height: 10),
                    XTextField(
                      onChanged: _changeComment,
                      placeholder: 'Add a comment',
                      maxLines: 3,
                      controller: _commentController,
                    ),
                    const SizedBox(height: 10),
                    XButton(
                      onPressed: _addComment,
                      child: const Text('Add Comment'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Color(0xFF326172),
                ),
                onPressed: _openBookmark,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.open_in_new, color: Colors.white),
                    const SizedBox(width: 5),
                    Text(
                      'Open Bookmark',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentView extends StatelessWidget {
  final Comment comment;

  const CommentView(this.comment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: Color(0xFF41A0C3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              comment.user.avatar != null
                  ? ClipOval(
                      child: Image.network(
                        comment.user.avatar!,
                        width: 20,
                        height: 20,
                        color: Colors.white,
                      ),
                    )
                  : Icon(Icons.person, color: Colors.white, size: 20),
              const SizedBox(width: 5),
              Text(
                comment.user.name,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              comment.content,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
