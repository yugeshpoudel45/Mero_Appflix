import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/components/buttons/primary_buttons/primary_long_button.dart';
import 'package:netflix/cubit/network_cubit.dart';
import 'package:netflix/cubit/network_state.dart';
import 'package:netflix/pages/2.onboarding_screen/datas.dart';

import '../../routes/app_route_constant.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  // Function to automatically go to the next page
  void _goToNextPage() {
    if (_pageController.page! < 2) {
      // Check if not on the last page
      _pageController.nextPage(
        duration: const Duration(
          milliseconds: 500,
        ),
        curve: Curves.ease,
      );
    }
  }

  setTimer() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      _goToNextPage();
      if (_pageController.page! >= 2) {
        timer.cancel(); // Stop the timer
      } else if (_pageController.page! < 2) {
        timer.isActive; // active the timer
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size mySize = MediaQuery.sizeOf(context);
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocListener<NetworkCubit, NetworkState>(
        listener: (context, state) {
          if (state == NetworkState.disconnected) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'PLEASE CONNECT TO THE INTERNET',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                backgroundColor: Colors.red[400],
                duration: const Duration(days: 1),
                behavior: SnackBarBehavior.fixed,
                dismissDirection: DismissDirection.none,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(onBoardingpages[_currentPage].imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: onBoardingpages.length,
                    onPageChanged: (int index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Text(
                            onBoardingpages[index].title,
                            textAlign: TextAlign.center,
                            style: myTextTheme.displaySmall!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: mySize.height / 64),
                          Text(
                            onBoardingpages[index].description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: mySize.height / 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onBoardingpages.length,
                    (index) => buildDot(index, context),
                  ),
                ),
                SizedBox(height: mySize.height / 32),
                PrimaryLongButton(
                    text: "Get Started",
                    func: () {
                      GoRouter.of(context).pushReplacementNamed(
                        MyAppRouteConstants.loginPage,
                      );
                    }),
                SizedBox(height: mySize.height / 64),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 12.0,
      width: 12.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: _currentPage == index ? myColorScheme.onTertiary : Colors.white,
      ),
    );
  }
}
