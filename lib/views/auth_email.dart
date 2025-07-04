import 'package:flutter/material.dart';
import 'package:link_verse/control/auth.dart';
import 'package:link_verse/control/validators.dart';
import 'package:link_verse/views/components/button.dart';
import 'package:link_verse/views/components/overlay_loading.dart';
import 'package:link_verse/views/components/text.dart';
import 'package:link_verse/views/components/text_field.dart';
import 'package:link_verse/views/components/logo.dart';
import 'package:link_verse/views/layouts/padding_layout.dart';
import 'package:link_verse/views/sign_up.dart';
import 'package:link_verse/views/sing_in.dart';

class AuthEmail extends StatefulWidget {
  const AuthEmail({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthEmailState();
  }
}

class _AuthEmailState extends State<AuthEmail> {
  String? email;
  String? error;

  void _onEmailChanged(String value) {
    email = value;
  }

  void _continue() {
    var error = emailValidator(email);
    if (error != this.error) {
      setState(() {
        this.error = error;
      });
    }
    if (error == null) {
      final loading = showLoadingOverlay(context);
      checkEmailExist(email!, (exist){
        loading.remove();
        if (exist) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SignInView(email: email!)));
        }else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpView(email: email!)));
        }
      });
    }
  }

  void _continueWithGoogle() {
    signInUserViaGoogle((ok){});
  }

  void _continueWithGithub() {
    signInUserViaGithub((ok){});
  }

  @override
  Widget build(BuildContext context) {
    return PaddingLayout(
      child: Column(
        children: [
          const XLogo(),
          const XHeadingText(
            'SingUp or SingIn',
            fontSize: 18,
            ),
          const SizedBox(height: 16),
          XTextField(
            onChanged: _onEmailChanged,
            placeholder: 'Email',
            prefixIcon: Icons.email_outlined,
            error: error,
          ),
          const SizedBox(height: 8),
          XButton(onPressed: _continue, child: const Text('Continue')),
          const SizedBox(height: 36),
          XButton(
            onPressed: _continueWithGoogle,
            child: Row(
              children: [
                Image.asset(
                  'assets/onboarding/google.png',
                  width: 24,
                  height: 24,
                ),
                const Expanded(
                  child: Text(
                    'Continue with Google',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          XButton(
            onPressed: _continueWithGithub,
            child: Row(
              children: [
                Image.asset(
                  'assets/onboarding/github.png',
                  width: 24,
                  height: 24,
                ),
                const Expanded(
                  child: Text(
                    'Continue with Google',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
