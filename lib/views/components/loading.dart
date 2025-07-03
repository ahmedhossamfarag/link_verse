import 'package:flutter/material.dart';

class XLoading extends StatelessWidget {
  const XLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}