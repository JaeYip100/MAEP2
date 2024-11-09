import 'package:flutter/material.dart';

// Import the widgets/pages for Tutee, Tutor, and Admin
/*import 'module_page_widget.dart';
import 'tutor_rating_system_widget.dart';
import 'saved_tutor_widget.dart';
import 'profile_screen.dart';
import 'badge_screen.dart';
import 'tutees_page.dart';
import 'tutors_page.dart';*/
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peer Tutoring App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
