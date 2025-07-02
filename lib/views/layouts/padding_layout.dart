import 'package:flutter/cupertino.dart';
import 'package:link_verse/views/layouts/gradiant_layout.dart';

class PaddingLayout extends StatelessWidget {
  final Widget child;

  const PaddingLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GradiantLayout(
        child: Padding(padding: const EdgeInsets.all(16), child: child));
  }
}
