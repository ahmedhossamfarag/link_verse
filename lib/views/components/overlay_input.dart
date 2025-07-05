import 'package:flutter/material.dart';
import 'package:link_verse/views/components/text_field.dart';

class XOverlayInputView extends StatefulWidget {
  final Function(String) callback;
  final String placeholder;
  final String? Function(String) validator;
  final Function() cancel;
  const XOverlayInputView({
    super.key,
    required this.callback,
    required this.placeholder,
    required this.validator,
    required this.cancel,
  });

  @override
  State<XOverlayInputView> createState() => _XOverlayInputViewState();
}

class _XOverlayInputViewState extends State<XOverlayInputView> {
  String value = '';
  String? error;

  void _changeValue(String value) {
    this.value = value;
  }

  void _submit() {
    final error = widget.validator(value);
    setState(() {
      this.error = error;
    });
    if (error != null) return;
    widget.callback(value);
  }

  void _cancel() {
    widget.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            XTextField(
              onChanged: _changeValue,
              placeholder: widget.placeholder,
              error: error,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                  ),
                  child: const Text('Submit'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _cancel,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class XOverlayInput {
  late OverlayEntry entry;
  final Function(String) callback;
  final String placeholder;
  final String? Function(String) validator;

  XOverlayInput(
    BuildContext context, {
    required this.callback,
    required this.placeholder,
    required this.validator,
  }) {
    final overlay = Overlay.of(context);
    entry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          Opacity(
            opacity: 0.9,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
          XOverlayInputView(
            callback: _callback,
            placeholder: placeholder,
            validator: validator,
            cancel: _cancel,
          ),
        ],
      ),
    );

    overlay.insert(entry);
  }

  void _callback(String value) {
    callback(value);
    entry.remove();
  }

  void _cancel() {
    entry.remove();
  }
}
