import 'package:flutter/material.dart';

class XTextField extends StatelessWidget{
  final void Function(String) onChanged;
  final String placeholder;
  final IconData? prefixIcon;
  final String? error;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextEditingController? controller;
  final int? maxLines;
  final bool? enabled;

  const XTextField({super.key, required this.onChanged, required this.placeholder, this.prefixIcon, this.error, this.validator, this.obscureText = false, this.controller, this.maxLines = 1, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
            label: Text(placeholder),
            alignLabelWithHint: true,
            floatingLabelStyle: const TextStyle(color: Colors.white, backgroundColor: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
            floatingLabelBehavior: prefixIcon != null ? FloatingLabelBehavior.never : null,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24)
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(color: Colors.blue)
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: Colors.red)
            ),
            errorText: error,
            errorStyle: const TextStyle(color: Colors.white),
            suffixIcon: error != null ? const Icon(Icons.error) : null
        ),
      validator: validator,
      obscureText: obscureText,
      maxLines: maxLines,
      enabled: enabled
    );
  }

}