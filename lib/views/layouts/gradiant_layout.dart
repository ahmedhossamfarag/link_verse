import 'package:flutter/material.dart';

class GradiantLayout extends StatelessWidget {
  final Widget child;

  const GradiantLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
            gradient:
            LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF326172), Color(0xFF4999B6)]
            )),
        child: child,
      ),
    );
  }
}
