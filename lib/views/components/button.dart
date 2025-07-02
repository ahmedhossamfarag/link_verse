import 'package:flutter/material.dart';

class XButton extends StatelessWidget{
  final void Function()? onPressed;
  final Widget child;

  const XButton({super.key, this.onPressed, required this.child});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 58)),
        child: child
    );
  }

}