import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dwm14/models/movie.dart';
import 'package:dwm14/screens/firebase.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  bool darkmode = false;
  dynamic savedThemeMode;
  void initState() {
  super.initState();
  getCurrentTheme();
}
Future getCurrentTheme() async {
  savedThemeMode = await AdaptiveTheme.getThemeMode();
  if (savedThemeMode.toString() == 'AdaptiveThemeMode.dark') {
    print('mode sombre');
    setState(() {
      darkmode = true;
    });
  } else {
    setState(() {
      darkmode = false;
    });
    print('mode clair');
  }
}

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
            
              title: SwitchListTile(
                title: Text('Mode sombre'),
                value: darkmode,
                activeColor: Colors.orange,
                onChanged: (bool value) {
                  print(value);
                  if (value == true) {
                    AdaptiveTheme.of(context).setDark();
                    
                  } else {
                    AdaptiveTheme.of(context).setLight();
                    
                  }
                  setState(() {
                    darkmode = value;
                  });
                },
                // secondary: const Icon(Icons.nightlight_round),
              ),
                
            onTap: () {
              AdaptiveTheme.of(context).toggleThemeMode();
              // Navigator.pushReplacementNamed(context, '/profile');
              print(darkmode);
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
