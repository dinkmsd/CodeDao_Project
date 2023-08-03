import 'package:flutter/material.dart';

class SnackBarCustom {
  static SnackBar snackBar(String result) {
    return SnackBar(
      content: Text(result),
      duration: Duration(seconds: 3),
    );
  }
}
