import 'package:flutter/material.dart';

class TutorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutor Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Action for Tutor Button
          },
          child: Text('Tutor Button'),
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
        title: Text('Tutee Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Action for Tutee Button
          },
          child: Text('Tutee Button'),
        ),
      ),
    );
  }
}