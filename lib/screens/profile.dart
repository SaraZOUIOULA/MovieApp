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
          centerTitle: true,
          title: Text('Profile'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Icon(Icons.edit),
            ),
          ],
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
                          return Container(
                            height: 500,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.all(Radius.circular(40)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.deepPurple[200],
                                    blurRadius: 25.0, 
                                    spreadRadius: 2.0, 
                                    
                                  )
                                ],
                            ),
                            child: Center(
                               
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                
                                Row(
                                  mainAxisAlignment : MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'First name: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold )
                                    ),
                                    Text(
                                      user[0].firstName, style: TextStyle(fontSize: 20)
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment : MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Name: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold )
                                    ),
                                    Text(
                                      user[0].name, style: TextStyle(fontSize: 20)
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment : MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'City: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold )
                                    ),
                                    Text(
                                      user[0].city, style: TextStyle(fontSize: 20)
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment : MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Email: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold )
                                    ),
                                    Text(
                                      user[0].email, style: TextStyle(fontSize: 20)
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          );
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
