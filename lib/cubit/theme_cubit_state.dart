import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/text_theme.dart';

class ThemeState {
  final ThemeData themeData;
  final Color color;

  ThemeState({required this.themeData, required this.color});

  factory ThemeState.light(Color color) {
    return ThemeState(themeData: _lightTheme(color), color: color);
  }

  factory ThemeState.dark(Color color) {
    return ThemeState(themeData: _darkTheme(color), color: color);
  }

  static ThemeData _lightTheme(Color color) {
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      textTheme: myTextTheme,
      fontFamily: GoogleFonts.inter().fontFamily,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: color,
        onTertiary: color,
        brightness: Brightness.light,
      ),
    );
    return theme;
  }

  static ThemeData _darkTheme(Color color) {
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      textTheme: myTextTheme,
      fontFamily: GoogleFonts.inter().fontFamily,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: color,
        onTertiary: color,
        brightness: Brightness.dark,
      ),
    );
    return theme;
  }


  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': themeData.brightness == Brightness.dark,
      'color': color.value,
    };
  }

  static ThemeState fromJson(Map<String, dynamic> json) {
    final bool isDarkMode = json['isDarkMode'] as bool;
    final Color color = Color(json['color'] as int);
    return isDarkMode ? ThemeState.dark(color) : ThemeState.light(color);
  }
}
