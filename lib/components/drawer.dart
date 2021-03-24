import 'package:dwm14/models/movie.dart';
import 'package:dwm14/screens/firebase.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Row(
              children: [
                Text('Movies App',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
              ],
            ),
          ),
          ListTile(
            title: Text('Home', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            title:
                Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/profile');
            },
          ),
          ListTile(
            title: Text(
              'Sign Out',
              style: TextStyle(
                  color: Colors.deepPurple, fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              await firebaseAuth.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      )),
    );
  }
}
