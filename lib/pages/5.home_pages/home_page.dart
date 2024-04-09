import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/components/images/network_image.dart';
import 'package:netflix/config/app_local_assets.dart';
import 'package:netflix/models/For%20APIs/trending_movie_model.dart';
import 'package:netflix/routes/app_route_constant.dart';

import '../../components/buttons/play_button/play_button.dart';
import '../../cubit/trending_section_cubit.dart';
import '../../models/For APIs/trending_tv_show_model.dart';
import '../../models/others/movie_carousel_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<TrendingSectionCubit>().onFetchingTrendingSection();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return BlocBuilder<TrendingSectionCubit, TrendingSectionState>(
      builder: (context, state) {
        if (state is TrendingSectionLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TrendingSectionErrorState) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else if (state is TrendingSectionLoadedState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _LocalCarouselModel(loadedState: state),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Trending Movies Today",
                            style: myTextTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily:
                                  GoogleFonts.balsamiqSans().fontFamily!,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context).pushNamed(
                                MyAppRouteConstants.trendingMoviesPage,
                                extra: state,
                              );
                            },
                            child: Text(
                              "See all",
                              style: myTextTheme.titleSmall!.copyWith(
                                color: myColorScheme.onTertiary,
                                fontWeight: FontWeight.bold,
                              ),
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
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                var movie =
                                    state.trendingMovieModel.results![index];

                                return GestureDetector(
                                  onTap: () {
                                    GoRouter.of(context).pushNamed(
                                      MyAppRouteConstants.movieDetailsPage,
                                      extra: movie.id,
                                    );
                                  },
                                  child: MovieCarouselModel(
                                    image: movie.posterPath.toString(),
                                    rating: movie.popularity!,
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
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
                            "Trending Shows Today",
                            style: myTextTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily:
                                  GoogleFonts.balsamiqSans().fontFamily!,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context).pushNamed(
                                MyAppRouteConstants.trendingTvShowsPage,
                                extra: state,
                              );
                            },
                            child: Text(
                              "See all",
                              style: myTextTheme.titleSmall!.copyWith(
                                color: myColorScheme.onTertiary,
                                fontWeight: FontWeight.bold,
                              ),
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
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                var tvShow =
                                    state.trendingTvShowModel.results![index];
                                return GestureDetector(
                                  onTap: () => GoRouter.of(context).pushNamed(
                                    MyAppRouteConstants.tvShowDetailsPage,
                                    extra: tvShow.id,
                                  ),
                                  child: MovieCarouselModel(
                                    image: tvShow.posterPath.toString(),
                                    rating: tvShow.popularity!,
                                  ),
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
                            "Trending Celebrities Today",
                            style: myTextTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily:
                                  GoogleFonts.balsamiqSans().fontFamily!,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context).pushNamed(
                                MyAppRouteConstants.trendingPeoplePage,
                                extra: state,
                              );
                            },
                            child: Text(
                              "See all",
                              style: myTextTheme.titleSmall!.copyWith(
                                color: myColorScheme.onTertiary,
                                fontWeight: FontWeight.bold,
                              ),
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
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              var person =
                                  state.trendingPeopleModel.results![index];
                              return MovieCarouselModel(
                                image: person.profilePath.toString(),
                                rating: person.popularity!,
                              );
                            },
                          ),
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
      },
    );
  }
}

class _LocalCarouselModel extends StatefulWidget {
  final TrendingSectionLoadedState loadedState;
  const _LocalCarouselModel({required this.loadedState});

  @override
  State<_LocalCarouselModel> createState() => __LocalCarouselModelState();
}

class __LocalCarouselModelState extends State<_LocalCarouselModel> {
  int currentPage = 0;
  final controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    Size mySize = MediaQuery.sizeOf(context);
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return CarouselSlider.builder(
      carouselController: controller,
      itemCount: 6,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        TrendingMovieModel fetchMovie = widget.loadedState.trendingMovieModel;
        TrendingTvShowModel fetchTvShow =
            widget.loadedState.trendingTvShowModel;
        String image = index % 2 == 0
            ? fetchMovie.results![index].backdropPath.toString()
            : fetchTvShow.results![index].backdropPath.toString();
        String movieName = index % 2 == 0
            ? fetchMovie.results![index].title.toString()
            : fetchTvShow.results![index].name.toString();
        String videoType = index % 2 == 0
            ? fetchMovie.results![index].mediaType.toString()
            : fetchTvShow.results![index].mediaType.toString();
        String releaseDate = index % 2 == 0
            ? fetchMovie.results![index].releaseDate!.year.toString()
            : fetchTvShow.results![index].firstAirDate!.year.toString();
        return Stack(alignment: Alignment.bottomCenter, children: [
          AppNetworkImage(
            image: "https://image.tmdb.org/t/p/original/$image",
            height: mySize.height / 2.5,
            width: mySize.width,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16,
              bottom: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: mySize.height / 40,
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
                SizedBox(height: mySize.height / 8),
                Text(
                  movieName,
                  style: myTextTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
                Row(
                  children: [
                    Text(
                      videoType == "MediaType.TV" ? "TV Show/" : "Movie/",
                      style: myTextTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      releaseDate,
                      style: myTextTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: mySize.height / 80),
                Row(
                  children: [
                    PlayButton(
                      icon: Icons.play_circle_fill_rounded,
                      text: "Play",
                      func: () {
                        index % 2 == 0
                            ? GoRouter.of(context).pushNamed(
                                MyAppRouteConstants.movieDetailsPage,
                                extra: fetchMovie.results![index].id,
                              )
                            : GoRouter.of(context).pushNamed(
                                MyAppRouteConstants.tvShowDetailsPage,
                                extra: fetchTvShow.results![index].id,
                              );
                        //! TODO: Change the routing for the trending TvShow here
                      },
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
                SizedBox(height: mySize.height / 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6,
                    (index) => buildDot(index, context),
                  ),
                )
              ],
            ),
          ),
        ]);
      },
      options: CarouselOptions(
        height: mySize.height / 2.5,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        viewportFraction: 1,
        onPageChanged: (i, reason) {
          setState(
            () {
              currentPage = i;
            },
          );
        },
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 8.0,
      width: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: currentPage == index ? myColorScheme.onTertiary : Colors.white,
      ),
    );
  }
}
