import 'package:flutter/material.dart';

class StyleCustom {
  static TextStyle redUnderline() {
    return const TextStyle(
        color: Colors.red, decoration: TextDecoration.underline);
  }

  static TextStyle blueUnderline() {
    return TextStyle(
        color: Colors.blueGrey[900], decoration: TextDecoration.underline);
  }
}
