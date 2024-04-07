import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/cubit/movie_details_cubit.dart';
import 'package:netflix/pages/2.onboarding_screen/pages.dart';
import 'package:netflix/pages/5.home_pages/main_page.dart';
import 'package:netflix/pages/6.Inside_home_pages/trending_movies_page.dart';
import 'package:netflix/pages/6.Inside_home_pages/trending_people_page.dart';
import 'package:netflix/pages/6.Inside_home_pages/trending_tvshow_page.dart';
import 'package:netflix/pages/7.movie_details/movie_details_screen.dart';
import 'package:netflix/pages/7.movie_details/movie_playing_screen.dart';
import 'package:netflix/pages/7.movie_details/movie_reviews_screen.dart';
import 'package:netflix/practice.dart';
import 'package:netflix/routes/app_route_constant.dart';

import '../cubit/trending_section_cubit.dart';
import '../demo_error_page.dart';
import '../demo_starting_page.dart';

class MyAppRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: MyAppRouteConstants.practicePage,
        path: '/practice',
        pageBuilder: (context, state) => const MaterialPage(child: Practice()),
      ),
      GoRoute(
        name: MyAppRouteConstants.demoStartingPageRouteName,
        path: '/',
        pageBuilder: (context, state) =>
            const MaterialPage(child: DemoStartingPage()),
      ),
      GoRoute(
        name: MyAppRouteConstants.onBoardingPage,
        path: '/onBoardingPage',
        pageBuilder: (context, state) =>
            const MaterialPage(child: OnboardingPage()),
      ),
      GoRoute(
        name: MyAppRouteConstants.mainPage,
        path: '/mainpage',
        pageBuilder: (context, state) => const MaterialPage(child: MainPage()),
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
        name: MyAppRouteConstants.moviePlayingPage,
        path: '/moviePlayingPage/:movieKey/:name',
        pageBuilder: (context, state) => MaterialPage(
          child: MoviePlayingScreen(
            movieKey: state.pathParameters['movieKey']!,
            name: state.pathParameters['name']!,
            loadedState: state.extra as MovieDetailsLoadedState,
          ),
        ),
      ),
      GoRoute(
        name: MyAppRouteConstants.movieReviewsPage,
        path: '/movieReviewsPage',
        pageBuilder: (context, state) => MaterialPage(
            child: MovieReviewsScreen(
          loadedState: state.extra as MovieDetailsLoadedState,
        )),
      ),
    ],
    errorPageBuilder: (context, state) {
      return const MaterialPage(
        child: ErrorPage(
          errorMessage: "Something Went Wrong during Routing",
        ),
      );
    },
  );
}
