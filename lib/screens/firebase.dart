import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dwm14/models/movie.dart';
import 'package:dwm14/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firebaseAuth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
isLogged() {
  return firebaseAuth.currentUser;
}

getMovie() async {
  List result = [];
  final movies = await firestore
      .collection('movies')
      .get(); // récupère tous les documents dans la BDD
  if (movies.docs != null) {
    // vérifie si il y a des résultats
    result = movies.docs
        .map((doc) => Movie().fromJson(doc.data()))
        .toList(); // le .doc formate les films dans un tableau de tous les objets. les map applique une fonction sur chaque élément du tableau. (doc) représente un élément. le toList trasforme tous les résultats en une list(tableau).
  }
  return result;
}

getUser() async {
  List result = [];
  final user = await firestore
      .collection('users')
      .where('email', isEqualTo: isLogged().email)
      .get();
  if (user.docs != null) {
    result = user.docs.map((doc) => UserProfil().fromJson(doc.data())).toList();
  }
  return result;
}

