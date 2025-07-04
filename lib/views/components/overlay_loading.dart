import 'package:flutter/material.dart';

OverlayEntry showLoadingOverlay(BuildContext context) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );

    overlay.insert(entry);

    return entry;
}