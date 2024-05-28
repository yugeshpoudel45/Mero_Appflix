import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:netflix/config/app_constants.dart';
import 'package:netflix/cubit/guest_session_cubit.dart';
import 'package:netflix/cubit/login_session_cubit.dart';
import 'package:netflix/cubit/movie_details_cubit.dart';
import 'package:netflix/cubit/movie_rating_cubit.dart';
import 'package:netflix/cubit/people_details_cubit.dart';
import 'package:netflix/cubit/search_section_cubit.dart';
import 'package:netflix/cubit/theme_cubit_cubit.dart';
import 'package:netflix/cubit/theme_cubit_state.dart';
import 'package:netflix/cubit/tv_show_details_cubit.dart';
import 'package:netflix/repo/auth/guest_session_repo.dart';
import 'package:netflix/repo/movie_details_repo.dart';
import 'package:netflix/repo/movie_rating_repo.dart';
import 'package:netflix/repo/people_details_repo.dart';
import 'package:netflix/repo/search_page_repo.dart';
import 'package:netflix/repo/trending_repo.dart';
import 'package:netflix/repo/tv_show_details_repo.dart';
import 'package:netflix/routes/app_route_config.dart';
import 'package:path_provider/path_provider.dart';
import 'cubit/trending_section_cubit.dart';
import 'repo/auth/login_session_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
  );
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
        BlocProvider(
          create: (context) => TvShowDetailsCubit(TvShowDetailsRepo()),
        ),
        BlocProvider(
          create: (context) => PeopleDetailsCubit(PeopleDetailsRepo()),
        ),
        BlocProvider(
          create: (context) => SearchSectionCubit(SearchRepo()),
        ),
        BlocProvider(
          create: (context) => MovieRatingCubit(MovieRatingRepo()),
        ),
        BlocProvider(
          create: (context) => GuestSessionCubit(GuestSessionRepo()),
        ),
        BlocProvider(
          create: (context) => LoginSessionCubit(LoginSessionRepo()),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: MyAppRouter().router,
            title: AppConstants.appName,
            theme: themeState.themeData,
          );
        },
      ),
    );
  }
}



//padding: const EdgeInsets.symmetric(horizontal: 16),

//Red Color
//Ff0000

//Netflix Color:
//E50914




