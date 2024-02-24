import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/routes/app_route_constant.dart';

class DemoStartingPage extends StatefulWidget {
  const DemoStartingPage({super.key});

  @override
  State<DemoStartingPage> createState() => _DemoStartingPageState();
}

class _DemoStartingPageState extends State<DemoStartingPage> {
  bool liked = true;
  int likeCounter = 45;
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
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     ListTile(
          //       leading: const CircleAvatar(
          //         backgroundImage:
          //             NetworkImage('https://example.com/avatar.jpg'),
          //       ),
          //       title: Text(
          //         'John Doe',
          //         style: myTextTheme.titleMedium!.copyWith(
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       subtitle: Text(
          //         '@johndoe',
          //         style: myTextTheme.labelLarge!.copyWith(
          //           fontFamily: GoogleFonts.balsamiqSans().fontFamily!,
          //         ),
          //       ),
          //       trailing: Column(
          //         children: [
          //           Icon(
          //             Icons.star_half_rounded,
          //             color: myColorScheme.onTertiary,
          //           ),
          //           const Text('8/10'),
          //         ],
          //       ),
          //     ),
          //     const Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 16.0),
          //       child: Text(
          //           'This is a great comment!This is a great comment!This is a great comment!This is a great comment!This is a great comment!This is a great comment!This is a great comment!This is a great comment!This is a great comment!This is a great comment!This is a great comment!'),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(
          //         left: 16,
          //         top: 12,
          //         right: 16,
          //       ),
          //       child: Row(
          //         children: [
          //           GestureDetector(
          //             onTap: () {
          //               setState(() {
          //                 liked = !liked;
          //                 if (liked == false) {
          //                   likeCounter++;
          //                 } else {
          //                   likeCounter--;
          //                 }
          //               });
          //             },
          //             child: Container(
          //                 child: liked
          //                     ? const Icon(
          //                         CupertinoIcons.heart,
          //                         color: Colors.grey,
          //                       )
          //                     : const Icon(
          //                         Icons.favorite,
          //                         color: Colors.red,
          //                       )),
          //           ),
          //           const SizedBox(
          //             width: 8,
          //           ),
          //           Text(
          //             "$likeCounter",
          //             style: myTextTheme.bodyMedium!.copyWith(
          //               color: Colors.grey,
          //             ),
          //           ),
          //           const SizedBox(
          //             width: 64,
          //           ),
          //           Text(
          //             '2023-03-02',
          //             style: myTextTheme.bodyMedium!.copyWith(
          //               color: Colors.grey,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     const Padding(
          //       padding: EdgeInsets.all(8.0),
          //       child: Divider(),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
