import 'package:flutter/material.dart';

abstract class BaseColors {
  static Color backgroundColor = const Color.fromARGB(255, 45, 170, 245);
  static Color foregroundColor = const Color.fromARGB(255, 223, 223, 223);
  static Color textColorLight = const Color.fromARGB(255, 255, 255, 255);
  static Color textColorDark = const Color.fromARGB(255, 0, 0, 0);
  static Color hintTextColor = const Color.fromARGB(255, 158, 158, 158);
  static Color textColorCustom = const Color.fromARGB(255, 25, 118, 210);
  static Color gradientColorOne = const Color.fromARGB(255, 140, 110, 255);
  static Color gradientColorTwo = backgroundColor;
  static Color buttonColorActive = const Color.fromARGB(255, 5, 165, 245);
  static Color buttonColorBlocked = const Color.fromARGB(255, 100, 180, 245);
  static Color deleteButtonColor = const Color.fromARGB(255, 255, 75, 75);
  static Color editButtonColor = const Color.fromARGB(255, 240, 200, 45);
  static Color shadowColor = backgroundColor;
  static Color textColorError = const Color.fromARGB(255, 255, 80, 80);
  static Color borderColorActive = backgroundColor;
  static Color borderColorBlocked = const Color.fromARGB(255, 158, 158, 158);
}
