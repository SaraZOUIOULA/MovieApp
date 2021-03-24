import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dwm14/models/movie.dart';
import 'package:dwm14/screens/firebase.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  

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
            title:
                Text('Mode sombre', style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(
              Icons.brightness_2,
              

            ),
            onTap: () {
              AdaptiveTheme.of(context).toggleThemeMode();
              // Navigator.pushReplacementNamed(context, '/profile');
              
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
