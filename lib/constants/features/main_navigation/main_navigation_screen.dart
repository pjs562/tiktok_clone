import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationScreen extends StatefulWidget {
  MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final screens = [
    const Center(
      child: Text('Home'),
    ),
    const Center(
      child: Text('Search'),
    ),
    const Center(
      child: Text('Home'),
    ),
    const Center(
      child: Text('Search'),
    ),
    const Center(
      child: Text('Home'),
    ),
  ];

  void _onTap(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: "Home",
            tooltip: "What are you?",
            backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: "Search",
            tooltip: "What are you?",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: "Search",
            tooltip: "What are you?",
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: "Search",
            tooltip: "What are you?",
            backgroundColor: Colors.yellow,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: "Search",
            tooltip: "What are you?",
            backgroundColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
