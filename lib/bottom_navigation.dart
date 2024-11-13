import 'package:flutter/material.dart';
import 'package:flutter_application_1/module_page_widgetb_page.dart';
 // Ensure this import is uncommented
// Uncomment or add additional imports for other widgets as needed

class BottomNavigation extends StatefulWidget {
  final String role;
  const BottomNavigation({super.key, required this.role});

  @override
  State<BottomNavigation> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  List<Widget> getNavigationPages() {
    if (widget.role == "Tutee") {
      return [
        const ModulePageWidget(),  // Module Page for Tutee role
        // Add other pages as needed for Tutee
      ];
    } else if (widget.role == "Tutor") {
      return [
        const ModulePageWidget(),  // Module Page for Tutor role
        // Add other pages as needed for Tutor
      ];
    } else {
      return [
        // Add pages for Admin or other roles as necessary
      ];
    }
  }

  List<BottomNavigationBarItem> getNavigationBarIcons() {
    if (widget.role == "Tutee") {
      return const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Find Tutor',
          icon: Icon(Icons.school_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Saved Tutor',
          icon: Icon(Icons.star_border),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(Icons.person_outline),
        ),
      ];
    } else if (widget.role == "Tutor") {
      return const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Badge',
          icon: Icon(Icons.military_tech_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(Icons.person_outline),
        ),
      ];
    } else {
      return const [
        BottomNavigationBarItem(
          label: 'Tutee List',
          icon: Icon(Icons.school_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Tutor List',
          icon: Icon(Icons.school),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(Icons.person_outline),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getNavigationPages()[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        showUnselectedLabels: true,
        onTap: (int selectedIndex) {
          setState(() {
            currentIndex = selectedIndex;
          });
        },
        currentIndex: currentIndex,
        items: getNavigationBarIcons(),
      ),
    );
  }
}
