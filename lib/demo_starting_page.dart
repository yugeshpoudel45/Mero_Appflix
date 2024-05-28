import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/routes/app_route_constant.dart';

class DemoStartingPage extends StatefulWidget {
  const DemoStartingPage({super.key});

  @override
  State<DemoStartingPage> createState() => _DemoStartingPageState();
}

class _DemoStartingPageState extends State<DemoStartingPage> {
  // @override
  // void initState() {
  //   MyListHelper.clearMovieList();
  //   MyListHelper.clearTvShowList();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    Size mySize = MediaQuery.sizeOf(context);
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                // log("Welcome to the World");
                // GoRouter.of(context).pushNamed(
                //   MyAppRouteConstants.practicePage,
                // );
                // GoRouter.of(context).pushNamed(
                //   MyAppRouteConstants.loginPage,
                // );
                GoRouter.of(context).pushNamed(
                  MyAppRouteConstants.mainPage,
                );
                // GoRouter.of(context).pushNamed(
                //   MyAppRouteConstants.peopleDetailsPage,
                //   extra: 500,
                // );
                // GoRouter.of(context).pushNamed(
                //   MyAppRouteConstants.tvShowDetailsPage,
                //   extra: 1400,
                // );
              },
              child: const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}

