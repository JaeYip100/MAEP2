import 'package:flutter/material.dart';
/*import 'module_page_widget.dart';
import 'tutor_rating_system_widget.dart';
import 'saved_tutor_widget.dart';
import 'profile_screen.dart';
import 'badge_screen.dart';
import 'tutees_page.dart';
import 'tutors_page.dart';*/

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
        /*const ModulePageWidget(),
        const TutorRatingSystemWidget(),
        const SavedTutorWidget(),
        const ProfileScreen(),*/
      ];
    } else if (widget.role == "Tutor") {
      return [
        /*const ModulePageWidget(),
        const BadgeScreen(),
        const ProfileScreen(),*/
      ];
    } else {
      return [
        /*const TuteesPage(),
        const TutorsPage(),
        const ProfileScreen(),*/
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
          label: 'Find tutor',
          icon: Icon(Icons.school_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Saved tutor',
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
