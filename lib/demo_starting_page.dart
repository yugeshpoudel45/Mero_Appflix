import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/routes/app_route_constant.dart';

class DemoStartingPage extends StatefulWidget {
  const DemoStartingPage({super.key});

  @override
  State<DemoStartingPage> createState() => _DemoStartingPageState();
}

class _DemoStartingPageState extends State<DemoStartingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            log("Welcome to the World");
            // GoRouter.of(context).pushNamed(
            //   MyAppRouteConstants.practicePage,
            // );
            GoRouter.of(context).pushNamed(
              MyAppRouteConstants.movieDetailsPage,
              extra: 500,
            );
              //  GoRouter.of(context).pushNamed(
              //                   MyAppRouteConstants.moviePlayingPage,
              //                   extra: movieVidoes.results![index].key,
              //                   pathParameters: {
              //                     'movieKey': movieVidoes.results![index].key!
              //                   },
              //                 );
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
