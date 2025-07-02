import 'package:flutter/material.dart';
import 'package:link_verse/views/components/button.dart';
import 'package:link_verse/views/components/logo.dart';
import 'package:link_verse/views/components/text_field.dart';
import 'package:link_verse/views/layouts/padding_layout.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  void _passwordChanged(String value) {
    // Handle password change
  }

  void _signIn() {
    // Handle sign in logic
  }

  @override
  Widget build(BuildContext context) {
    return PaddingLayout(
      child: Column(
        children: [
          const XLogo(),
          const SizedBox(height: 20),
          XTextField(
            onChanged: _passwordChanged,
            placeholder: "Password",
            obscureText: true,
            prefixIcon: Icons.lock,
          ),
          const SizedBox(height: 8),
          XButton(onPressed: _signIn, child: const Text("Sign In")),
        ],
      ),
    );
  }
}
