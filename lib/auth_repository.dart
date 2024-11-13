import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> login(TextEditingController emailController, TextEditingController passwordController) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } catch (e) {
      // Handle error accordingly, e.g., log the error or rethrow
      rethrow;
    }
  }
}
