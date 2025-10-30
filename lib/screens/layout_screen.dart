import 'package:flutter/material.dart';
import 'package:job_seeker/screens/Profile/profile_screen.dart';

import 'applications_screen.dart';
import 'home_screen.dart';
import 'jobs_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int currentIndex = 0;

  final List<String> titles = const <String>[
    'Home',
    'Jobs',
    'My Applications',
    'Profile',
  ];

  final List<Widget> screens = const <Widget>[
    HomeScreen(),
    JobsScreen(),
    ApplicationsScreen(),
    ProfileScreen(),
  ];

  final List<NavigationDestination> destinations =
      const <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: "Home",
        ),
        NavigationDestination(
          icon: Icon(Icons.work_outline),
          selectedIcon: Icon(Icons.work),
          label: "Jobs",
        ),
        NavigationDestination(
          icon: Icon(Icons.article_outlined),
          selectedIcon: Icon(Icons.article),
          label: "Applied",
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: "Profile",
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        title: Text(
          titles[currentIndex],
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      // body: currentIndex == 3
      //     ? Column(children: [screens[currentIndex], _buildFloatingButton()])
      //     : screens[currentIndex],
      body: screens[currentIndex],

      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.transparent,
        indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
        elevation: 0,
        height: 70,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: destinations,
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  // Widget _buildFloatingButton() {
  //   return FloatingActionButton(
  //     onPressed: () {
  //       // Add your button's onPressed logic here
  //     },
  //     backgroundColor: Theme.of(context).colorScheme.secondary,
  //     elevation: 0,
  //     splashColor: Colors.transparent,
  //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //     child: Icon(Icons.add),
  //   );
  // }
}
