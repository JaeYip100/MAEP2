import 'package:flutter/material.dart';
import 'package:flutter_application_1/find_tutor_page.dart';
import 'package:flutter_application_1/study_material_page.dart';


 // Assuming this is the correct provider
import 'login.dart';
  // Assuming this is the page where the review happens

class ModulePageWidget extends StatelessWidget {
  const ModulePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Action'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to StudyMaterialPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StudyMaterialPage()),
                );
              },
              child: const Text('Go to Study Materials'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to TutorRatingSystemWidget
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FindTutorPage()),
                );
              },
              child: const Text('Find and Rate Tutors'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Log out and navigate to LoginPage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

