import 'package:flutter/material.dart';

import 'package:netflix/components/buttons/other_buttons/info_button.dart';
import 'package:netflix/data/movie_crew_data.dart';

import '../../components/buttons/play_button/play_button.dart';
import '../../config/app_local_assets.dart';
import '../../models/movie_crew_model.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen>
    with TickerProviderStateMixin {
  late final _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              AppAssets.onBoard1,
              height: mySize.height / 2.5,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
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
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(
                        icon: Icon(
                          Icons.grid_on_sharp,
                          size: 28,
                          color: Colors.black,
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.account_box_outlined,
                          size: 28,
                          color: Colors.black,
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.account_box_outlined,
                          size: 28,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            height: 400,
                            width: double.infinity,
                            color: Colors.red,
                          ),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            height: 400,
                            width: double.infinity,
                            color: Colors.green,
                          ),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            height: 400,
                            width: double.infinity,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
