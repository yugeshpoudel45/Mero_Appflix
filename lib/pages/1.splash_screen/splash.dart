// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:go_router/go_router.dart';
// // import 'package:netflix/components/local_storage/login_checker.dart';
// // import 'package:netflix/routes/app_route_constant.dart';

// // class SplashScreen extends StatefulWidget {
// //   const SplashScreen({super.key});

// //   @override
// //   State<SplashScreen> createState() => _SplashScreenState();
// // }

// // class _SplashScreenState extends State<SplashScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Splash Screen'),
// //         centerTitle: true,
// //       ),
// //       body: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Center(
// //             child: ElevatedButton(
// //               onPressed: () {
// //                 Fluttertoast.showToast(
// //                   msg: 'Welcome to the world of Appflix!',
// //                   backgroundColor: Colors.green,
// //                 );
// //                 // log("Welcome to the World");
// //                 // GoRouter.of(context).pushNamed(
// //                 //   MyAppRouteConstants.practicePage,
// //                 // );
// //                 // GoRouter.of(context).pushNamed(
// //                 //   MyAppRouteConstants.loginPage,
// //                 // );
// //                 // GoRouter.of(context).pushNamed(
// //                 //   MyAppRouteConstants.mainPage,
// //                 // );
// //                 Future.wait([
// //                   MyLogin.getLoggedInValue(),
// //                 ]).then((value) {
// //                   Fluttertoast.showToast(
// //                     msg: "Success",
// //                     backgroundColor: Colors.green,
// //                   );
// //                   value.first
// //                       ? GoRouter.of(context).pushReplacementNamed(
// //                           MyAppRouteConstants.mainPage,
// //                         )
// //                       : GoRouter.of(context).pushReplacementNamed(
// //                           MyAppRouteConstants.onBoardingPage,
// //                         );
// //                 });
// //               },
// //               child: const Text('Login'),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // //!Animated wala splash Screen banaune
// // //!Net chaleko xa ki xaina vanera surumai check garne

// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:lottie/lottie.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     TextTheme myTextTheme = Theme.of(context).textTheme;
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Lottie.asset(
//               'assets/splash.json',
//               controller: _controller,
//               onLoaded: (composition) {
//                 _controller
//                   ..duration = composition.duration
//                   ..forward();
//               },
//             ),
//             Text(
//               "Mero Appflix",
//               style: myTextTheme.displayMedium!.copyWith(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/components/local_storage/login_checker.dart';
import 'package:netflix/routes/app_route_constant.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    // Listen for when the animation completes to navigate to the next page
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToNextPage();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToNextPage() {
    Future.wait([MyLogin.getLoggedInValue()]).then((value) {
      value.first
          ? GoRouter.of(context)
              .pushReplacementNamed(MyAppRouteConstants.mainPage)
          : GoRouter.of(context)
              .pushReplacementNamed(MyAppRouteConstants.onBoardingPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/splash.json',
              controller: _controller,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
            ),
            Text(
              "Mero Appflix",
              style: myTextTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
