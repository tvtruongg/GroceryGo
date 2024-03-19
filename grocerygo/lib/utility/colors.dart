import 'dart:math';

import 'package:flutter/material.dart';

const Color primary = Color.fromARGB(255, 83, 177, 117); // #53B175
const Color primaryText = Color.fromRGBO(3, 3, 3, 1);
const Color secondaryText = Color.fromRGBO(130, 130, 130, 1);
const Color textTitle = Color.fromRGBO(124, 124, 124, 1);
const Color placeHolder = Color.fromRGBO(177, 177, 177, 1);
const Color redColor = Color.fromRGBO(230, 46, 4, 1);

Color getRandomColor() {
  Random random = Random();
  List<Color> colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];
  return colors[random.nextInt(colors.length)];
}