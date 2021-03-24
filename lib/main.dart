import 'package:dwm14/routes.dart';
import 'package:dwm14/screens/error.dart';
import 'package:dwm14/screens/firebase.dart';
import 'package:dwm14/screens/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';


void main() async {
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
            return AdaptiveTheme(
              light: ThemeData(
                brightness: Brightness.light,
                primarySwatch: Colors.deepPurple,
                
              ),
              dark: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.orange,
                
              ),
                initial: AdaptiveThemeMode.light,
                builder: (theme, darkTheme) => MaterialApp(
                title: 'Movie App',
                debugShowCheckedModeBanner: false,
                theme: theme,
                darkTheme: darkTheme,
                routes: routes,
                initialRoute: isLogged() != null ? '/home' : '/login',
            ));
            
          }

          return LoadingScreen();
        });
  }
}
