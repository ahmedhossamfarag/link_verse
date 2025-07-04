import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


Future<void> checkEmailExist(String email, Function(bool) callback) async {
  final db = FirebaseFirestore.instance;
  final snapshot = await db
      .collection('users')
      .where('email', isEqualTo: email)
      .limit(1)
      .get();
  callback(snapshot.docs.isNotEmpty);
}

Future<void> singUpUser(
  String name,
  String email,
  String password,
  Function(bool, String?) callback,
) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'name': name, 'email': email});
    callback(true, null);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      callback(false, 'Email already in use');
    } else {
      callback(false, 'Unexpected error: ${e.code}');
      // throw Exception('Unexpected error: ${e.code}');
    }
  }
}

Future<void> singInUserViaEmail(
  String email,
  String password,
  Function(bool, {String? message}) callback,
) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    callback(true);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      callback(false, message: 'User not found');
    } else if (e.code == 'wrong-password') {
      callback(false, message: 'Wrong password');
    } else {
      callback(false, message: 'Unexpected error: ${e.code}');
    }
  }
}

Future<void> signInUserViaGoogle(Function(bool) callback) async {}

Future<void> signInUserViaGithub(Function(bool) callback) async {}

Future<void> singOutUser() async {
  await FirebaseAuth.instance.signOut();
}
