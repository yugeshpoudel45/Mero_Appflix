import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:netflix/config/app_local_assets.dart';

import '../../components/buttons/play_button/play_button.dart';
import '../../config/app_constants.dart';
import '../../data/movie_carousel_data.dart';
import '../../models/movie_carousel_model.dart';
import '../../models/trending_people_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  String myimage = "";
  String myrating = "";

  final String accessUrl =
      'https://api.themoviedb.org/3/trending/tv/day?language=en-US';

  Future<void> _fetchTrendingMovies() async {
    Map<String, String> headers = {
      'accept': 'application/json',
      "Authorization": "Bearer $accessToken",
    };
    try {
      http.Response response = await http.get(
        Uri.parse(accessUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final trendingPeopleModel =
            trendingPeopleModelFromJson(response.body.toString());
        log(response.body.toString());

        log(trendingPeopleModel.page.toString());
        log(trendingPeopleModel.results![0].name.toString());
        setState(() {
          myimage = trendingPeopleModel.results![0].posterPath.toString();
          myrating = trendingPeopleModel.results![0].voteAverage.toString();
        });
      } else {
        log("Hello World");
        log(response.statusCode.toString());
        log(response.body.toString());
      }
    } catch (e) {
      print("Exception caught: $e");
    }
  }

  @override
  void initState() {
    isLoading = true;
    _fetchTrendingMovies();
    isLoading = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: mySize.height / 2.5,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.onBoard1),
                      fit: BoxFit.cover,
                      opacity: 0.9,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: mySize.height / 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              AppAssets.appLogo,
                              height: mySize.height / 24,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.search,
                                  color: Colors.white,
                                  size: 32,
                                ),
                                SizedBox(width: mySize.width / 20),
                                const Icon(
                                  CupertinoIcons.bell,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          "Fast & Furious",
                          style: myTextTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Action. Superhero. Science. Fiction.",
                          style: myTextTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: mySize.height / 80),
                        Row(
                          children: [
                            PlayButton(
                              icon: Icons.play_circle_fill_rounded,
                              text: "Play",
                              func: () {},
                            ),
                            SizedBox(width: mySize.width / 24),
                            PlayButton(
                              isFilled: false,
                              width: 104,
                              icon: Icons.add,
                              text: "My List",
                              func: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Top 10 Movies This Week",
                            style: myTextTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily:
                                  GoogleFonts.balsamiqSans().fontFamily!,
                            ),
                          ),
                          Text(
                            "See all",
                            style: myTextTheme.titleSmall!.copyWith(
                              color: myColorScheme.onTertiary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: mySize.height / 64),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...movieCarouselData
                                .map(
                                  (e) => MovieCarouselModel(
                                    image: e['image'],
                                    rating: e['rating'],
                                  ),
                                )
                                .toList(),
                            // MovieCarouselModel(
                            //     image: myimage, rating: myrating),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding:
                //       const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                //   child: Column(
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             "New Releases",
                //             style: myTextTheme.titleLarge!.copyWith(
                //               fontWeight: FontWeight.bold,
                //               fontFamily:
                //                   GoogleFonts.balsamiqSans().fontFamily!,
                //             ),
                //           ),
                //           Text(
                //             "See all",
                //             style: myTextTheme.titleSmall!.copyWith(
                //               color: myColorScheme.onTertiary,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //         ],
                //       ),
                //       SizedBox(height: mySize.height / 64),
                //       SingleChildScrollView(
                //         scrollDirection: Axis.horizontal,
                //         child: Row(
                //           children: [
                //             ...movieCarouselData
                //                 .map(
                //                   (e) => MovieCarouselModel(
                //                     image: e['image'],
                //                     rating: e['rating'],
                //                   ),
                //                 )
                //                 .toList(),
                //             // MovieCarouselModel(
                //             //     image: myimage, rating: myrating),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          );
  }
}
