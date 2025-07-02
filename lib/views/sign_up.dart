import 'package:flutter/material.dart';
import 'package:link_verse/views/components/button.dart';
import 'package:link_verse/views/components/logo.dart';
import 'package:link_verse/views/components/text_field.dart';
import 'package:link_verse/views/layouts/padding_layout.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  void _nameChanged(String value) {
    // Handle email change
  }

  void _passwordChanged(String value) {
    // Handle password change
  }

  void _confirmPasswordChanged(String value) {
    // Handle confirm password change
  }

  void _signUp() {
    // Handle sign up logic
  }

  @override
  Widget build(BuildContext context) {
    return PaddingLayout(
      child: Column(
        children: [
          const XLogo(),
          const SizedBox(height: 20),
          XTextField(
            onChanged: _nameChanged,
            placeholder: "Name",
            prefixIcon: Icons.person,
          ),
          const SizedBox(height: 8),
          XTextField(
            onChanged: _passwordChanged,
            placeholder: "Password",
            obscureText: true,
            prefixIcon: Icons.lock,
          ),
          const SizedBox(height: 8),
          XTextField(
            onChanged: _confirmPasswordChanged,
            placeholder: "Confirm Password",
            obscureText: true,
            prefixIcon: Icons.lock,
          ),
          const SizedBox(height: 8),
          XButton(onPressed: _signUp, child: const Text("Sign Up")),
        ],
      ),
    );
  }
}
