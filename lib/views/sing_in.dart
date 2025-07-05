import 'package:flutter/material.dart';
import 'package:link_verse/control/auth.dart';
import 'package:link_verse/views/components/button.dart';
import 'package:link_verse/views/components/logo.dart';
import 'package:link_verse/views/components/overlay_loading.dart';
import 'package:link_verse/views/components/text_field.dart';
import 'package:link_verse/views/home.dart';
import 'package:link_verse/views/layouts/padding_layout.dart';

class SignInView extends StatefulWidget {
  final String email;
  const SignInView({super.key, required this.email});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String password = '';

  void _passwordChanged(String value) {
    password = value;
  }

  void _signIn() {
    final loading = showLoadingOverlay(context);
    singInUserViaEmail(widget.email, password, (ok, {message}) {
      loading.remove();
      if (ok) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message!)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PaddingLayout(
      child: SingleChildScrollView(
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
      ),
    );
  }
}
