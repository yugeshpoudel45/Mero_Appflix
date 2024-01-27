import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/themes/text_theme.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  textTheme: myTextTheme,
  fontFamily: GoogleFonts.inter().fontFamily!,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.red,
    onTertiary: Colors.red,
    //Changing onTertiary color so that i can use same color in both light and dark theme
    brightness: Brightness.light,
  ),
);
