import 'package:dwm14/routes.dart';
import 'package:dwm14/screens/error.dart';
import 'package:dwm14/screens/firebase.dart';
import 'package:dwm14/screens/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorScreen();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Movie App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.deepPurple,
              ),
              routes: routes,
              initialRoute: isLogged() != null ? '/home' : '/login',
            );
          }

          return LoadingScreen();
        });
  }
}
