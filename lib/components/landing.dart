import 'package:dwm14/models/movie.dart';
import 'package:dwm14/screens/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  const Landing({
    Key key,
  }) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMovie(),
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
                  child: Text('No movies'),
                );
              }
              List movies = snapshot.data;
              return ListView.builder(
                //itère sur toute les élément du tableau
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Padding(

                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/detail',
                              arguments: ItemArguments(movie: movies[index]));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 430,
                              width: 293,
                              decoration: BoxDecoration(
                                  image: DecorationImage( 
                                    image: NetworkImage(//récupere une image sur le net par une url (string)
                                      movies[index].poster)
                                  ),
                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[600],
                                    blurRadius: 25.0, 
                                    spreadRadius: 2.0, 
                                    offset: Offset(
                                      15.0, 
                                      15.0, 
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(movies[index].title, style: TextStyle( fontSize: 30),),
                            Text(movies[index].year),
                            SizedBox(
                              height: 10,
                            ),
                            Text(movies[index].kind.join(', ')),
                            // Column(
                            //   children: List.generate(
                            //       movies[index].kind.length,
                            //       (indexKind) =>
                            //           Text(movies[index].kind[indexKind])),
                            // )
                          ],
                        ),

                      )
                      
                  );
                      
                }
                  
                

              );

          }
      }
        
    );
        
  }
}
