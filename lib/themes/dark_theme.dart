import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/themes/text_theme.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  textTheme: myTextTheme,
  fontFamily: GoogleFonts.inter().fontFamily!,
  appBarTheme: const AppBarTheme(elevation: 0),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.red,
    onTertiary: Colors.red,
    brightness: Brightness.dark,
  ),
);
