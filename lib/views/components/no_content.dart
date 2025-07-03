import 'package:flutter/material.dart';

class XNoContent extends StatelessWidget {
  final String image;

  const XNoContent({super.key, this.image = 'assets/main/no-content.png'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        image,
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }
}