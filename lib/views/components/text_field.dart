import 'package:flutter/material.dart';

class XTextField extends StatelessWidget{
  final void Function(String) onChanged;
  final String placeholder;
  final IconData? prefixIcon;
  final String? error;
  final String? Function(String?)? validator;
  final bool obscureText;

  const XTextField({super.key, required this.onChanged, required this.placeholder, this.prefixIcon, this.error, this.validator, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
            label: Text(placeholder),
            floatingLabelStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
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
    );
  }

}