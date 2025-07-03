import 'package:flutter/material.dart';
import 'package:link_verse/views/layouts/nav_layout.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return NavLayout(selectedIndex: 2);
  }
}
