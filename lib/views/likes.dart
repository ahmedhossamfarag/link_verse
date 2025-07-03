import 'package:flutter/material.dart';

class LikesView extends StatelessWidget {
  final String? title = 'Favorites';
  const LikesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Likes View',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
