import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'jokes_list_screen.dart';  // Import your JokesListScreen here
import 'favorites_jokes_screen.dart';  // Import your FavoriteJokesScreen here

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of screens for Bottom Navigation
  final List<Widget> _screens = [
    JokesListScreen(type: 'Funny'), // You can replace 'Funny' with dynamic types
    FavoriteJokesScreen(), // This will show the favorite jokes
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jokes App'),
        backgroundColor: Colors.yellow[100],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
