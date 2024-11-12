import 'package:flutter/material.dart';
import 'package:mae_assignment/find_tutor_page.dart';
// import 'package:mae_assignment/module_page_widget.dart';
import 'package:mae_assignment/saved_tutor_page.dart';
// import 'package:mae_assignment/saved_tutor_widget.dart';
// import 'package:mae_assignment/peer_tutor_badge.dart';
// import 'package:mae_assignment/profile_page.dart';
import 'package:mae_assignment/module_page.dart';

class BottomNavigation extends StatefulWidget {
  final String role;
  const BottomNavigation({super.key, required this.role});

  @override
  State<BottomNavigation> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  List<Widget> navigationPagesForTutee = [
    const TestModuleCopy(), //Module page
    const TutorRatingSystemWidgetCopy(), //Tutor rating system page
    const SavedTutorCopy(), //Saved tutor information page
    // const ProfileScreen(), //Profile page
  ];

  // List<Widget> navigationPagesForTutor = [
  //   const ModulePageWidget(), //Module page
  //   const BadgeScreen(), //Badge page
  //   const ProfileScreen(), //Profile page
  // ];

  // List<Widget> navigationPagesForAdmin = [
  //   const ModulePageWidget(), //Tutee list Page
  //   const BadgeScreen(), //Tutor list page
  //   const ProfileScreen(), //Profile page
  // ];

  List<BottomNavigationBarItem> navigationBarItemForTutee = const [
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
    // BottomNavigationBarItem(
    //   label: 'Profile',
    //   icon: Icon(Icons.person_outline),
    // )
  ];

  // List<BottomNavigationBarItem> navigationBarItemForTutor = const [
  //   BottomNavigationBarItem(
  //     label: 'Home',
  //     icon: Icon(Icons.home_outlined),
  //   ),
  //   BottomNavigationBarItem(
  //     label: 'Badge',
  //     icon: Icon(Icons.military_tech_outlined),
  //   ),
  //   BottomNavigationBarItem(
  //     label: 'Profile',
  //     icon: Icon(Icons.person_outline),
  //   )
  // ];

  // List<BottomNavigationBarItem> navigationBarItemForAdmin = const [
  //   BottomNavigationBarItem(
  //     label: 'Tutor List',
  //     icon: Icon(Icons.school_outlined),
  //   ),
  //   BottomNavigationBarItem(
  //     label: 'Tutee List',
  //     icon:  Icon(Icons.school),
  //   ),
  //   BottomNavigationBarItem(
  //     label: 'Profile',
  //     icon: Icon(Icons.person_outline),
  //   )
  // ];

  //Return a list of navigation pages based on the user role.
  List<Widget> getNavigationPages()
  {
    return navigationPagesForTutee;
    // else if (widget.role == "Tutor")
    // {
    //   return navigationPagesForTutor;
    // }
    // else
    // {
    //   return navigationPagesForAdmin;
    // }
  }

  List<BottomNavigationBarItem> getNavigationBarIcons()
  {
    return navigationBarItemForTutee;
    // else if (widget.role == "Tutor")
    // {
    //   return navigationBarItemForTutor;
    // }
    // else
    // {
    //   return navigationBarItemForAdmin;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getNavigationPages()[currentIndex],
      bottomNavigationBar : BottomNavigationBar(
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