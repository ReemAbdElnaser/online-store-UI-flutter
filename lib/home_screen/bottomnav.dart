import 'package:flutter/material.dart';
import 'home.dart';
import 'package:project_app/categories/CategoriesPage.dart';
import 'package:project_app/screen/about.dart';
import 'package:project_app/screen/TeamPage.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    CategoryScreen(),
    AboutAppPage(),
    AboutTeamPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 210, 190, 245), // اللون الخلفي للـ BottomNavigationBar
        selectedItemColor:   Colors.deepPurple ,// لون العنصر المحدد
        unselectedItemColor: Colors.grey, // لون العنصر غير المحدد
        items:const  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
         
         
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),

           BottomNavigationBarItem(
           icon: Icon(Icons.group),
            label: 'Team',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

