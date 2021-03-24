import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
final String title, plot, runtime, year, poster; // si toutes les variable ont le même type on peut les déclarer comme ceci. il faut qu'elle s soient écritent de la même façon que dans la BDD 
final List actors, kind, ratings;
final Timestamp releasedDate;

  Movie( 
    {this.title,
    this.plot,
    this.runtime,
    this.year,
    this.poster,
    this.actors,
    this.kind,
    this.ratings,
    this.releasedDate});

  fromJson(json){
    return Movie(
      title: json['title'],
      plot: json['plot'],
      runtime: json['runtime'],
      year: json['year'],
      poster: json['poster'],
      actors: json['actors'],
      kind: json['kind'],
      ratings: json['ratings'],
      releasedDate: json['releasedDate']
    );
  }
}
class ItemArguments {
  final String text;
  final Movie movie;

  ItemArguments({this.text, this.movie });
}
 