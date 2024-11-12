import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profilepage.dart'; // Import the ProfilePage

class TutorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutor Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Action for Tutor Button
              },
              child: const Text('Tutor Button'),
            ),
            const SizedBox(height: 20), // Space between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to Profile Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      user: FirebaseAuth.instance.currentUser,
                    ),
                  ),
                );
              },
              child: const Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class TuteePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutee Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Action for Tutee Button
              },
              child: const Text('Tutee Button'),
            ),
            const SizedBox(height: 20), // Space between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to Profile Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      user: FirebaseAuth.instance.currentUser,
                    ),
                  ),
                );
              },
              child: const Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
