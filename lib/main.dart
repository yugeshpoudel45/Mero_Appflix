import 'package:flutter/material.dart';
import 'package:netflix/config/app_constants.dart';
import 'package:netflix/pages/login_pages/direct_login.dart';
import 'package:netflix/pages/login_pages/login_screen.dart';
import 'package:netflix/pages/login_pages/register_screen.dart';
import 'package:netflix/pages/onboarding_screen/pages.dart';
import 'package:netflix/themes/dark_theme.dart';
import 'package:netflix/themes/light_theme.dart';

void main() {
  runApp(const MyApp());
}
//TODO add the preserve and remove the native splash screen here, and also remove it after initialization.

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      title: AppConstants.appName,
      theme: lightTheme,
      darkTheme: darkTheme,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const LoginScreen(),
    );
  }
}

//Red Color
//Ff0000

//Netflix Color:
//E50914
