import 'package:flutter/material.dart';

import 'package:netflix/components/buttons/other_buttons/info_button.dart';
import 'package:netflix/data/movie_crew_data.dart';

import '../../components/buttons/play_button/play_button.dart';
import '../../config/app_local_assets.dart';
import '../../data/movie_carousel_data.dart';
import '../../models/movie_carousel_model.dart';
import '../../models/movie_crew_model.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              const SliverToBoxAdapter(
                child: Column(
                  children: [
                    _MyMovieDetails(),
                    TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(
                          text: "Trailers",
                        ),
                        Tab(
                          text: "More Like This",
                        ),
                        Tab(
                          text: "Comments",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: <Widget>[
              Icon(Icons.flight, size: 350),
              _MoreLikeThisTab(),
              Icon(Icons.directions_car, size: 350),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyMovieDetails extends StatelessWidget {
  const _MyMovieDetails();

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Image.asset(
          AppAssets.onBoard1,
          height: mySize.height / 2.5,
          width: double.maxFinite,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Men in Black",
                    style: myTextTheme.headlineSmall,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.bookmark_border_rounded),
                      SizedBox(width: mySize.width / 24),
                      const Icon(Icons.share_outlined),
                    ],
                  ),
                ],
              ),
              SizedBox(height: mySize.height / 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.star_half_rounded,
                    color: myColorScheme.onTertiary,
                  ),
                  Text(
                    "9.8",
                    style: myTextTheme.labelLarge!.copyWith(
                      color: myColorScheme.onTertiary,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: myColorScheme.onTertiary,
                  ),
                  const Text("2022"),
                  InfoButton(
                    text: "13+",
                    func: () {},
                  ),
                  InfoButton(
                    text: "USA",
                    func: () {},
                  ),
                  InfoButton(
                    text: "Subtitle",
                    func: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PlayButton(
                      icon: Icons.play_circle_fill_outlined,
                      text: "Play",
                      func: () {},
                      height: mySize.height / 16,
                      width: mySize.width / 2.3,
                    ),
                    PlayButton(
                      icon: Icons.download_outlined,
                      text: "Download",
                      func: () {},
                      height: mySize.height / 16,
                      width: mySize.width / 2.3,
                      isFilled: false,
                      isDownloadButton: true,
                    ),
                  ],
                ),
              ),
              const Text(
                "Genre: Action, Superhero, Science Fiction, Romance, Thriller",
              ),
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis fugit aspernatur saepe inventore eos vitae, recusandae incidunt",
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      ...movieCrewData.map(
                        (e) => const MovieCrewModel(
                          image: 'e[image]',
                          name: 'e[name]',
                          role: 'e[role]',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MoreLikeThisTab extends StatelessWidget {
  const _MoreLikeThisTab();

  @override
  Widget build(BuildContext context) {
    Size mySize = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 16,
        right: 8,
        bottom: 8,
      ),
      child: Wrap(
        children: [
          ...movieCarouselData
              .map(
                (e) => MovieCarouselModel(
                  width: mySize.width / 2.25,
                  height: mySize.height / 3.2,
                  image: e['image'],
                  rating: e['rating'],
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
