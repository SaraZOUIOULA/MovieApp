import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  const Square({Key key, this.color = Colors.purple, this.number})
      : super(key: key);

  final Color color;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: color,
      child: Center(child: Text(number.toString())),
    );
  }
}