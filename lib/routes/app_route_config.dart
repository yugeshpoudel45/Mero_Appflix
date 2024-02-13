import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/pages/5.home_pages/main_page.dart';
import 'package:netflix/pages/6.Inside_home_pages/trending_movies_page.dart';
import 'package:netflix/pages/6.Inside_home_pages/trending_people_page.dart';
import 'package:netflix/pages/6.Inside_home_pages/trending_tvshow_page.dart';
import 'package:netflix/routes/app_route_constant.dart';

import '../blocs/cubit/trending_section_cubit.dart';
import '../demo_error_page.dart';
import '../demo_starting_page.dart';

class MyAppRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: MyAppRouteConstants.demoStartingPageRouteName,
        path: '/',
        pageBuilder: (context, state) =>
            const MaterialPage(child: DemoStartingPage()),
      ),
      GoRoute(
        name: MyAppRouteConstants.mainPage,
        path: '/mainpage',
        pageBuilder: (context, state) => const MaterialPage(child: MainPage()),
      ),
      GoRoute(
        name: MyAppRouteConstants.trendingMoviesPage,
        path: '/trendingMoviesPage/:state',
        pageBuilder: (context, state) => MaterialPage(
          child: TrendingMoviesPage(
            state: state.extra as TrendingSectionLoadedState,
          ),
        ),
        //!Fix this, yo easily fix hunxa, as hamile string pass gareko xum state ko thau ma, so just pass the state here
      ),
      GoRoute(
        name: MyAppRouteConstants.trendingPeoplePage,
        path: '/trendingPeoplePage',
        pageBuilder: (context, state) =>
            const MaterialPage(child: TrendingPeoplePage()),
      ),
      GoRoute(
        name: MyAppRouteConstants.trendingTvShowsPage,
        path: '/trendingTvShowsPage',
        pageBuilder: (context, state) =>
            const MaterialPage(child: TrendingTvShowsPage()),
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
