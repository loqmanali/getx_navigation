import 'package:flutter/material.dart';
import 'package:getx_core/getx_core.dart';
import 'package:getx_navigation/getx_navigation.dart';

/// Example demonstrating how to use GetShellRoute with BottomNavigationBar
/// This provides the same functionality as go_router's ShellRoute
class BottomNavigationExample extends StatefulWidget {
  const BottomNavigationExample({super.key});

  @override
  State<BottomNavigationExample> createState() =>
      _BottomNavigationExampleState();
}

class _BottomNavigationExampleState extends State<BottomNavigationExample> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Navigation Shell Route Example',
      initialRoute: '/home',
      getPages: [
        // Shell route with persistent BottomNavigationBar
        createBottomNavigationShell(
          name: '/shell',
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          getCurrentIndex: () => _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            // Navigate to the corresponding route
            switch (index) {
              case 0:
                Get.toNamed('/home');
                break;
              case 1:
                Get.toNamed('/search');
                break;
              case 2:
                Get.toNamed('/profile');
                break;
            }
          },
          shellChildren: [
            GetPage(name: '/home', page: () => const HomePage()),
            GetPage(name: '/search', page: () => const SearchPage()),
            GetPage(name: '/profile', page: () => const ProfilePage()),
          ],
        ),
      ],
    );
  }
}

// Example pages
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 100, color: Colors.blue),
          SizedBox(height: 20),
          Text(
            'Home Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text('This is the home page with persistent bottom navigation'),
        ],
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 100, color: Colors.green),
          SizedBox(height: 20),
          Text(
            'Search Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text('This is the search page with persistent bottom navigation'),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 100, color: Colors.orange),
          SizedBox(height: 20),
          Text(
            'Profile Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text('This is the profile page with persistent bottom navigation'),
        ],
      ),
    );
  }
}
