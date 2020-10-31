import 'package:flutter/material.dart';

class TxtApp extends StatelessWidget {
  final Color colour;
  final double size;
  final bool bold;
  final String txt;

  const TxtApp({
    Key key,
    @required this.txt,
    @required this.colour,
    @required this.size,
    this.bold = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return bold == true
        ? Text(
            txt,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: colour,
              fontSize: size,
              fontWeight: FontWeight.bold,
            ),
          )
        : Text(
            txt,
            textAlign: TextAlign.left,
            style: TextStyle(color: colour, fontSize: size),
          );
  }
}
