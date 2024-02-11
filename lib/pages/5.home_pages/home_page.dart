import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/config/app_local_assets.dart';

import '../../blocs/cubit/home_page_cubit.dart';
import '../../components/buttons/play_button/play_button.dart';
import '../../data/movie_carousel_data.dart';
import '../../models/movie_carousel_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomePageCubit>().onFetchingTrendingMovies();
  }

  String myimage = "";
  String myrating = "";

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return BlocBuilder<HomePageCubit, HomePageState>(builder: (context, state) {
      if (state is HomePageLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is HomePageErrorState) {
        return Center(
          child: Text(state.errorMessage),
        );
      } else if (state is HomePageLoadedState) {
        myimage = state.trendingMovieModel.results![0].posterPath.toString();
        myrating = state.trendingMovieModel.results![0].voteAverage.toString();
        return SingleChildScrollView(
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
                          "Top 5 Movies This Week",
                          style: myTextTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.balsamiqSans().fontFamily!,
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
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            // itemCount: state.trendingMovieModel.results!.length,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return MovieCarouselModel(
                                image: state.trendingMovieModel.results![index]
                                    .posterPath
                                    .toString(),
                                rating: state.trendingMovieModel.results![index]
                                    .voteAverage
                                    .toString(),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Top 5 Celebrities This Week",
                          style: myTextTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.balsamiqSans().fontFamily!,
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
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            // itemCount: state.trendingMovieModel.results!.length,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return MovieCarouselModel(
                                image: state.trendingMovieModel.results![index]
                                    .posterPath
                                    .toString(),
                                rating: state.trendingMovieModel.results![index]
                                    .voteAverage
                                    .toString(),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
