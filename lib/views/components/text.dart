import 'package:flutter/material.dart';

class XHeadingText extends StatelessWidget {
  final String text;
  final double fontSize;

  const XHeadingText(this.text, {
    super.key,
    this.fontSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'Inter',
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}