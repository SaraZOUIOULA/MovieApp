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

    final List ratings = args.movie.ratings;

    final date = args.movie.releasedDate.toDate().toString().substring(0,10);
    

    return Scaffold(
      
          endDrawer: DrawerMenu(),
        appBar: AppBar(
          leading: Builder( // apparement dans la nouvelle version de flutter on ne peut plus mettre une fleche retour et un endDrawer. D'où le mide en place de code.
          builder: (BuildContext context) {
            final ScaffoldState scaffold = Scaffold.maybeOf(context);
            final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);
            final bool hasEndDrawer = scaffold?.hasEndDrawer ?? false;
            final bool canPop = parentRoute?.canPop ?? false;

            if (hasEndDrawer && canPop) {
              return BackButton();
            } else {
              return SizedBox.shrink();
            }
          },
        ),
          centerTitle: true,
          title: Text("Movie's detail" ),
        ),


        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                color: Colors.deepPurple[200] ,
                width: 500,
                height: 100,
                child: Center(child: Text(args.movie.title,style: TextStyle(fontSize: 40, color: Colors.black), textAlign: TextAlign.center)),
              ),

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
                          color: Colors.deepPurple[200],
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
              SizedBox(height: 30),

            
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('RunTime: ' + args.movie.runtime + ' min',
                              style: TextStyle(fontSize: 15)),
                          Text('Year : ' + args.movie.year,
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(args.movie.plot,
                          style: TextStyle(fontSize: 17),
                          textAlign: TextAlign.justify),
                      SizedBox(height: 10),

                      Text('Genre', style: TextStyle(fontSize: 25)),
                      Text(args.movie.kind.join(', '),
                          style: TextStyle(fontSize: 17)),
                      SizedBox(height: 10),

                      Text('Released Date', style: TextStyle(fontSize: 25)),
                      Text(date, style: TextStyle(fontSize: 17)),
                      SizedBox(height: 10),

                     
                      Text('Acthors', style: TextStyle(fontSize: 25)),
                      Text(args.movie.actors.join(', '),
                          style: TextStyle(fontSize: 17)),

                      SizedBox(height: 10),
                      Text('Rating', style: TextStyle(fontSize: 25)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Ratings(args: args, index: 0),
                          Ratings(args: args, index: 1),
                          Ratings(args: args, index: 2),
                        ],
                      ),
                      
                     
                    ])),
                ),
              )
            ]))),        
                      
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
      
      )
    );
  }
}
    
class Ratings extends StatelessWidget {
  const Ratings({
    Key key,
    this.index,
    @required this.args,
  }) : super(key: key);

  final ItemArguments args;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(args.movie.ratings[index]['logo'])),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Text(args.movie.ratings[index]['source'], style: TextStyle(fontSize: 15)),
        SizedBox(
          width: 10,
        ),
        Text(args.movie.ratings[index]['value'], style: TextStyle(fontSize: 20)),
      ]),
    );
  }
}
