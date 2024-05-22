import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void callSnackBar() {}

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? "",
          ),
        ),
      );
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? "",
          ),
        ),
      );
    }
  }

  Future<void> googleSignin() async {
    await _firebaseAuth.signInWithProvider(GoogleAuthProvider());
  }

  Future<void> microsoftSignin() async {
    await _firebaseAuth.signInWithProvider(MicrosoftAuthProvider());
  }

  Future<void> githubSignin() async {
    await _firebaseAuth.signInWithProvider(GithubAuthProvider());
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
