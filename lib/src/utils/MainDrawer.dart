import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/AboutUs.dart';
import '../pages/Manual.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 3,
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Image.asset('assets/logow.png'),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              'Home',
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              'About Us',
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(AboutUs.routeName);
            },
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(Manual.routeName);
            },
            leading: Icon(
              Icons.account_box,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              'User Manual',
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Divider(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Center(
            child: Text(
              'Designed & Developed by GADS',
              style: GoogleFonts.openSans(color: Colors.grey[600]),
            ),
          ),
          Center(
            child: Text(
              'V 1.0.0',
              style: GoogleFonts.openSans(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}
