import 'package:dwm14/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:dwm14/screens/firebase.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedPage = 1;

  _onTap(int index) async {
    switch (index) {
      case 2:
        await firebaseAuth.signOut();
        Navigator.pushReplacementNamed(context, '/login');
        break;
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      default:
        setState(() {
          _selectedPage = index;
        });
        break;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        drawer: DrawerMenu(),
        body: SafeArea(
            child: Center(
                child: FutureBuilder(
                    future: getUser(),
                    builder: (context, snapshot) {
                      // snapshot est le résultat de la futur
                      switch (snapshot.connectionState) {
                        // le .connnectionState permet de vérifier si elle a finit de tourné
                        case ConnectionState.waiting: //en attente
                          return Center(
                              child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator()));
                        default: // Future terminée
                          if (!snapshot.hasData) {
                            //hasData est un bolléen
                            return Center(
                              child: Text('No profil'),
                            );
                          }
                          List user = snapshot.data;
                          return Column(children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                                'Name : ' +
                                    user[0].firstName +
                                    ' ' +
                                    user[0].name,
                                style: TextStyle(fontSize: 20)),
                            SizedBox(height: 10),
                            Text('City : ' + user[0].city,
                                style: TextStyle(fontSize: 20)),
                            SizedBox(height: 10),
                            Text('Email : ' + user[0].email,
                                style: TextStyle(fontSize: 20))
                          ]);
                      }
                    }))),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'Sign out',
            ),
          ],
          currentIndex: _selectedPage,
          selectedItemColor: Colors.deepPurple[500],
          onTap: _onTap,
        ));
  }
}
