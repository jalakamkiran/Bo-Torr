import 'package:flutter/material.dart';
import 'package:libgen/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
      scaffoldBackgroundColor: primaryBackgroundColor,
      textTheme: GoogleFonts.exo2TextTheme().apply(
        displayColor: Colors.white,
        bodyColor: Colors.white
      ),

  );
}
