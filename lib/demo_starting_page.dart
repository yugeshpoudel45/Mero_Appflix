// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:netflix/routes/app_route_constant.dart';

// class DemoStartingPage extends StatefulWidget {
//   const DemoStartingPage({super.key});

//   @override
//   State<DemoStartingPage> createState() => _DemoStartingPageState();
// }

// class _DemoStartingPageState extends State<DemoStartingPage> {
//   @override
//   Widget build(BuildContext context) {
//     ColorScheme myColorScheme = Theme.of(context).colorScheme;
//     Size mySize = MediaQuery.sizeOf(context);
//     TextTheme myTextTheme = Theme.of(context).textTheme;
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 log("Welcome to the World");
//                 GoRouter.of(context).pushNamed(
//                   MyAppRouteConstants.practicePage,
//                 );
//                 // GoRouter.of(context).pushNamed(
//                 //   MyAppRouteConstants.mainPage,
//                 // );
//                 // GoRouter.of(context).pushNamed(
//                 //   MyAppRouteConstants.peopleDetailsPage,
//                 //   extra: 500,
//                 // );
//                 // GoRouter.of(context).pushNamed(
//                 //   MyAppRouteConstants.tvShowDetailsPage,
//                 //   extra: 1400,
//                 // );
//               },
//               child: const Text('Login'),
//             ),
//           ),
//           // AnimatedCarouselModel(items: urlImages),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/others/search_filter_model.dart';

class DemoStartingPage extends StatelessWidget {
  const DemoStartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    Size mySize = MediaQuery.sizeOf(context);
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: mySize.height / 16,
                    width: mySize.width / 1.4,
                    child: const CupertinoSearchTextField(),
                  ),
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: myColorScheme.secondaryContainer,
                      padding: const EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return const SearchFilterModal();
                        },
                      );
                    },
                    icon: const Icon(
                      CupertinoIcons.color_filter,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
