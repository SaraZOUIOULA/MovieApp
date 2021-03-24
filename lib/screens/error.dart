import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Firebase Error',
        home: Scaffold(
          body: SafeArea(
            child: Center(
              child: Text('Error during loading', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28
              )),
            ),
          ),
        ));
  }
}
