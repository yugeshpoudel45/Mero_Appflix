import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/components/Error/error_page.dart';
import 'package:netflix/pages/1.splash_screen/splash.dart';
import 'package:netflix/pages/2.onboarding_screen/pages.dart';
import 'package:netflix/pages/3.login_page/login_screen.dart';
import 'package:netflix/pages/4.home_pages/main_page.dart';
import 'package:netflix/pages/5.Inside_home_pages/trending_movies_page.dart';
import 'package:netflix/pages/5.Inside_home_pages/trending_people_page.dart';
import 'package:netflix/pages/5.Inside_home_pages/trending_tvshow_page.dart';
import 'package:netflix/pages/6.%20Inside_profile_page.dart/about_us_page.dart';
import 'package:netflix/pages/6.%20Inside_profile_page.dart/themes_page.dart';
import 'package:netflix/pages/7.movie_details/movie_details_screen.dart';
import 'package:netflix/pages/7.movie_details/playing_screen.dart';
import 'package:netflix/pages/7.movie_details/reviews_screen.dart';
import 'package:netflix/pages/7.movie_details/tv_show_details_screen.dart';
import 'package:netflix/routes/app_route_constant.dart';

import '../cubit/trending_section_cubit.dart';
import '../pages/7.movie_details/people_details_screen.dart';

class MyAppRouter {
  GoRouter router = GoRouter(
    routes: [
      //!--------------------------------------------------------------------------------------------------------------------------
      //!-------------------------------------------------This is home route-------------------------------------------------------
      GoRoute(
        name: MyAppRouteConstants.splashScreen,
        path: '/',
        pageBuilder: (context, state) => const MaterialPage(
          child: MainPage(),
        ),
      ),
      //!--------------------------------------------------------------------------------------------------------------------------
      GoRoute(
        name: MyAppRouteConstants.loginPage,
        path: '/loginPage',
        pageBuilder: (context, state) => const MaterialPage(
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        name: MyAppRouteConstants.onBoardingPage,
        path: '/onBoardingPage',
        pageBuilder: (context, state) => const MaterialPage(
          child: OnboardingPage(),
        ),
      ),
      GoRoute(
        name: MyAppRouteConstants.mainPage,
        path: '/mainpage',
        pageBuilder: (context, state) => const MaterialPage(
          child: MainPage(),
        ),
      ),
      GoRoute(
        name: MyAppRouteConstants.trendingMoviesPage,
        path: '/trendingMoviesPage',
        pageBuilder: (context, state) => MaterialPage(
          child: TrendingMoviesPage(
            loadedState: state.extra as TrendingSectionLoadedState,
          ),
        ),
      ),
      GoRoute(
        name: MyAppRouteConstants.trendingPeoplePage,
        path: '/trendingPeoplePage',
        pageBuilder: (context, state) => MaterialPage(
            child: TrendingPeoplePage(
          loadedState: state.extra as TrendingSectionLoadedState,
        )),
      ),
      GoRoute(
        name: MyAppRouteConstants.trendingTvShowsPage,
        path: '/trendingTvShowsPage',
        pageBuilder: (context, state) => MaterialPage(
            child: TrendingTvShowsPage(
          loadedState: state.extra as TrendingSectionLoadedState,
        )),
      ),
      GoRoute(
        name: MyAppRouteConstants.movieDetailsPage,
        path: '/movieDetailsPage',
        pageBuilder: (context, state) => MaterialPage(
          child: MovieDetailsScreen(movieId: state.extra as int),
        ),
      ),
      GoRoute(
        name: MyAppRouteConstants.tvShowDetailsPage,
        path: '/tvShowDetailsPage',
        pageBuilder: (context, state) => MaterialPage(
          child: TvShowDetailsScreen(movieId: state.extra as int),
        ),
      ),
      GoRoute(
        name: MyAppRouteConstants.peopleDetailsPage,
        path: '/peopleDetailsPage',
        pageBuilder: (context, state) => MaterialPage(
          child: PeopleDetailsScreen(peopleId: state.extra as int),
        ),
      ),
      GoRoute(
        name: MyAppRouteConstants.playingPage,
        path: '/playingPage/:movieKey/:name/:isMovie',
        pageBuilder: (context, state) => MaterialPage(
          child: PlayingPage(
            movieKey: state.pathParameters['movieKey']!,
            name: state.pathParameters['name']!,
            isMovie: state.pathParameters['isMovie'] == 'true' ? true : false,
            loadedState: state.extra as dynamic,
          ),
        ),
      ),
      GoRoute(
        name: MyAppRouteConstants.reviewsPage,
        path: '/reviewsPage/:isMovie',
        pageBuilder: (context, state) => MaterialPage(
            child: ReviewsScreen(
          loadedState: state.extra as dynamic,
          isMovie: state.pathParameters['isMovie'] == 'true' ? true : false,
        )),
      ),
      GoRoute(
        name: MyAppRouteConstants.themesPage,
        path: '/themesPage',
        pageBuilder: (context, state) => const MaterialPage(
          child: ThemesPage(),
        ),
      ),
      GoRoute(
        name: MyAppRouteConstants.aboutUsPage,
        path: '/aboutUsPage',
        pageBuilder: (context, state) => const MaterialPage(
          child: AboutUs(),
        ),
      ),
    ],
    errorPageBuilder: (context, state) {
      return const MaterialPage(
        child: ShowErrorMessage(
          errorMessage: "Something Went Wrong during Routing",
          extraInfo: 'Please check the route name and path',
        ),
      );
    },
  );
}
