import 'package:flutter/material.dart';
import 'package:flutter_application_1/find_tutor_page.dart';
import 'login.dart'; // Import LoginPage
import 'study_material_page.dart'; 
 

class TutorHomePage extends StatelessWidget {
  const TutorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutor Home'),
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
                // Navigate to TutorRatingPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  FindTutorPage()),
                );
              },
              child: const Text('View Ratings'),
            ),
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
