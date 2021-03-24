import 'package:dwm14/components/drawer.dart';
import 'package:dwm14/models/movie.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _selectedPage = 1;
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

  Widget build(BuildContext context) {
    final ItemArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text("Movie's detail"),
        ),
        drawer: DrawerMenu(),

        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(args.movie.title, style: TextStyle(fontSize: 40)),
              SizedBox(height: 10),
              Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(args.movie.poster)
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[600],
                          blurRadius: 25.0, // soften the shadow
                          spreadRadius: 2.0, //extend the shadow
                          offset: Offset(
                            15.0, // Move to right 10  horizontally
                            15.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('RunTime: ' + args.movie.runtime + ' min',
                            style: TextStyle(fontSize: 15)),
                        Text('Year : ' + args.movie.year, style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(args.movie.plot, style: TextStyle(fontSize: 17), textAlign: TextAlign.justify),
                    SizedBox(height: 10),
                    Text('Genre', style: TextStyle(fontSize: 25)),
                    Text(args.movie.kind.join(', '), style: TextStyle(fontSize: 17)),
                    SizedBox(height: 10),
                    Text('Acthors', style: TextStyle(fontSize: 25)),
                    Text(args.movie.actors.join(', '),
                        style: TextStyle(fontSize: 17),textAlign: TextAlign.center),
                    SizedBox(height: 10),
                  ],
                
                ),
              ),
            ],
        ))
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
