import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './MobileAppPage.dart';
import './RobotPage.dart';

class Manual extends StatefulWidget {
  static const routeName = '/manual';
  @override
  _ManualState createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'screen': RobotPage(),
        'title': 'Robot',
      },
      {
        'screen': MobileAppPage(),
        'title': 'Mobile App',
      }
    ];
    super.initState();
  }

  void _selectScreen(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Middle Man',
          style: GoogleFonts.openSans(),
        ),
      ),
      body: _pages[_selectedPageIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 12,
        onTap: _selectScreen,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.adb),
            label: 'Robot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mobile_friendly),
            label: 'Mobile App',
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.black,
        currentIndex: _selectedPageIndex,
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
