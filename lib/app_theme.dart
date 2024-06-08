import 'package:flutter/material.dart';
import 'package:libgen/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: primaryBackgroundColor,
    textTheme: GoogleFonts.exo2TextTheme()
        .apply(displayColor: Colors.white, bodyColor: Colors.white),
  );

  static LinearGradient appGradient = const LinearGradient(colors: [
    Color(0xFF232526),
    Color(0xFF414345),
  ], stops: [
    0.3,
    1.0
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}
