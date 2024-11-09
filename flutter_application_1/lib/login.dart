import 'package:flutter/material.dart';
import 'bottom_navigation.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                color: Colors.blue,
                size: 100,
              ),
              const SizedBox(height: 20),
              _inputField("Email"),
              const SizedBox(height: 20),
              _inputField("Password", isPassword: true),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Simulate successful login based on user role
                  String role = "Tutee"; // Change this as needed for testing
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavigation(role: role),
                    ),
                  );
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Login",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Go to sign up page.
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
