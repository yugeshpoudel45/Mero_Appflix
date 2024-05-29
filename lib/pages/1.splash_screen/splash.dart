import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/routes/app_route_constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg: 'Welcome to the world of Appflix!',
                  backgroundColor: Colors.green,
                );
                // log("Welcome to the World");
                // GoRouter.of(context).pushNamed(
                //   MyAppRouteConstants.practicePage,
                // );
                // GoRouter.of(context).pushNamed(
                //   MyAppRouteConstants.loginPage,
                // );
                // GoRouter.of(context).pushNamed(
                //   MyAppRouteConstants.mainPage,
                // );
                GoRouter.of(context).pushNamed(
                  MyAppRouteConstants.onBoardingPage,
                );
              },
              child: const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}
