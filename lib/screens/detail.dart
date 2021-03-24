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
    setState(() {
      _selectedPage = index;
    });
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
              Text(args.movie.title, style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(args.movie.poster))),
              ),
              SizedBox(height: 10),
              Text(args.movie.plot, style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text(args.movie.kind.join(', '), style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text(args.movie.actors.join(', '),
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text('RunTime: ' + args.movie.runtime + ' min',
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text('Year : ' + args.movie.year, style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
            ],
          ),
        )),
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
