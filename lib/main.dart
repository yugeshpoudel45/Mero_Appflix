import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/config/app_constants.dart';
import 'package:netflix/pages/5.home_pages/main_page.dart';

import 'package:netflix/repo/trending_repo.dart';
import 'package:netflix/themes/dark_theme.dart';
import 'package:netflix/themes/light_theme.dart';

import 'blocs/cubit/home_page_cubit.dart';

void main() {
  runApp(const MyApp());
}
//TODO add the preserve and remove the native splash screen here, and also remove it after initialization.

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { 
    return BlocProvider(
      create: (context) => HomePageCubit(TrendingRepo()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        // themeMode: ThemeMode.dark,
        title: AppConstants.appName,
        theme: lightTheme,
        darkTheme: darkTheme,
        // home: const HomePage(),
        home: const MainPage(),
      ),
    );
  }
}


//padding: const EdgeInsets.symmetric(horizontal: 16),

//Red Color
//Ff0000

//Netflix Color:
//E50914
