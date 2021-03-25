import 'package:dwm14/components/drawer.dart';
import 'package:dwm14/components/landing.dart';
import 'package:dwm14/screens/detail.dart';
import 'package:flutter/material.dart';
import '../components/square.dart';

final PageController ctrl = PageController();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  int nb = 0;
  Color color = Colors.blue;
  bool disable = false;

  _onTap(int index) {
    switch (index) {
      case 1:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      default:
    setState(() {
      _selectedPage = index;
    });
  }
  }

  List<Widget> list = [
    Landing(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Welcome to our Movie App'),
        ),
        drawerEnableOpenDragGesture: !disable,
        endDrawer: DrawerMenu(),
        body: SafeArea(
          child: 
          list[_selectedPage],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              
            ),
          ],
          currentIndex: _selectedPage,
          selectedItemColor: Colors.deepPurple[500],
          onTap: (index) {
            _onTap(index);
          },
        ));
  }
}
