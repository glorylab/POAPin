import 'package:flutter/material.dart';

class PColor {
  static Color done = Colors.green;
  static Color background = const Color(0xFFF2F2F2);

  static Color welook = const Color(0xFFEC4899);
  static Color welookDark = const Color(0xFF932C60);

  static const MaterialColor primary = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(_primaryValue),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );
  static const int _primaryValue = 0xFF6750A4;
}
