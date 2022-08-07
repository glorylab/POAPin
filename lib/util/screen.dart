import 'package:flutter/material.dart';

class ScreenHelper {
  static double getHorizontalPadding(context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 768) {
      return (width - 768) / 2;
    } else {
      return 16;
    }
  }

  static double getFullHorizontalPadding(context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 768) {
      return (width - 768) / 2;
    } else {
      return 0;
    }
  }
}
