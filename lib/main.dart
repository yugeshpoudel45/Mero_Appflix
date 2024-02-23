import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/config/app_constants.dart';
import 'package:netflix/cubit/movie_details_cubit.dart';
import 'package:netflix/repo/movie_details_repo.dart';
import 'package:netflix/repo/trending_repo.dart';
import 'package:netflix/routes/app_route_config.dart';
import 'package:netflix/themes/dark_theme.dart';
import 'package:netflix/themes/light_theme.dart';
import 'cubit/trending_section_cubit.dart';

void main() {
  runApp(const MyApp());
}
//TODO add the preserve and remove the native splash screen here, and also remove it after initialization.

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TrendingSectionCubit(TrendingRepo()),
        ),
        BlocProvider(
          create: (context) => MovieDetailsCubit(MoviesDetailsRepo()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: MyAppRouter().router,
        // themeMode: ThemeMode.light,
        themeMode: ThemeMode.dark,
        title: AppConstants.appName,
        theme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
  }
}


//padding: const EdgeInsets.symmetric(horizontal: 16),

//Red Color
//Ff0000

//Netflix Color:
//E50914
