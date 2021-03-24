import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Firebase Loading',
        home: Scaffold(
          body: SafeArea(
            child: Center(
              child: Text('Loading...', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28
              )),
            ),
          ),
        ));
  }
}
