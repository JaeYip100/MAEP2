// signup.dart
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create an Account',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              _inputField("Email"),
              const SizedBox(height: 20),
              _inputField("Password", isPassword: true),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Add sign-up logic here
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Sign Up",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(String hintText, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
    );
  }
}
