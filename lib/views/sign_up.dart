import 'package:flutter/material.dart';
import 'package:link_verse/control/auth.dart';
import 'package:link_verse/control/validators.dart';
import 'package:link_verse/views/components/button.dart';
import 'package:link_verse/views/components/logo.dart';
import 'package:link_verse/views/components/overlay_loading.dart';
import 'package:link_verse/views/components/text_field.dart';
import 'package:link_verse/views/home.dart';
import 'package:link_verse/views/layouts/padding_layout.dart';

class SignUpView extends StatefulWidget {
  final String email;
  const SignUpView({super.key, required this.email});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String name = '';
  String password = '';
  String confirmPassword = '';

  String? nameError;
  String? passwordError;
  String? confirmPasswordError;

  void _nameChanged(String value) {
    name = value;
  }

  void _passwordChanged(String value) {
    password = value;
  }

  void _confirmPasswordChanged(String value) {
    confirmPassword = value;
  }

  void _signUp() {
    var nameError = nameValidator(name);
    var passwordError = passwordValidator(password);
    var confirmPasswordError = confirmPasswordValidator(confirmPassword, password);
    setState(() {
      this.nameError = nameError;
      this.passwordError = passwordError;
      this.confirmPasswordError = confirmPasswordError;
    });
    if (nameError == null && passwordError == null && confirmPasswordError == null) {
      final overlayEnrty = showLoadingOverlay(context);
      singUpUser(name, widget.email, password, (ok, message){
        overlayEnrty.remove();
        if (ok) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeView()));
        }else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message!)));
        }
      });
    }
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
            error: nameError,
          ),
          const SizedBox(height: 8),
          XTextField(
            onChanged: _passwordChanged,
            placeholder: "Password",
            obscureText: true,
            prefixIcon: Icons.lock,
            error: passwordError,
          ),
          const SizedBox(height: 8),
          XTextField(
            onChanged: _confirmPasswordChanged,
            placeholder: "Confirm Password",
            obscureText: true,
            prefixIcon: Icons.lock,
            error: confirmPasswordError,
          ),
          const SizedBox(height: 8),
          XButton(onPressed: _signUp, child: const Text("Sign Up")),
        ],
      ),
    );
  }
}
