import 'package:flutter/material.dart';

class CollectionsView extends StatelessWidget {
  final String? title = 'Collections';
  final IconData? actionIcon = Icons.add;
  const CollectionsView({super.key});

  void addCollection() {
    // Logic to add a new collection
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Collections View'));
  }
}
