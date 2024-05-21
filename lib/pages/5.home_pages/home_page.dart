import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/config/app_constants.dart';

import 'package:netflix/components/images/cache_network_image.dart';
import 'package:netflix/config/app_local_assets.dart';
import 'package:netflix/routes/app_route_constant.dart';

import '../../components/buttons/play_button/play_button.dart';
import '../../cubit/trending_section_cubit.dart';
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
          var movie = state.trendingMovieModel.results!
              .where((element) =>
                  element.posterPath != AppConstants.placeHolderImage)
              .toList();
          var tvShow = state.trendingTvShowModel.results!
              .where((element) =>
                  element.posterPath != AppConstants.placeHolderImage)
              .toList();
          var people = state.trendingPeopleModel.results!
              .where((element) =>
                  element.profilePath != AppConstants.placeHolderImage)
              .toList();
          return SingleChildScrollView(
            child: Column(
              children: [
                _LocalCarouselModel(
                  loadedState: state,
                  movie: movie,
                  tvShow: tvShow,
                ),
                movie.isEmpty
                    ? const SizedBox()
                    : Padding(
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
                                movie.length <= 5
                                    ? const SizedBox()
                                    : GestureDetector(
                                        onTap: () {
                                          GoRouter.of(context).pushNamed(
                                            MyAppRouteConstants
                                                .trendingMoviesPage,
                                            extra: state,
                                          );
                                        },
                                        child: Text(
                                          "See all",
                                          style:
                                              myTextTheme.titleSmall!.copyWith(
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        movie.length > 5 ? 5 : movie.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          GoRouter.of(context).pushNamed(
                                            MyAppRouteConstants
                                                .movieDetailsPage,
                                            extra: movie[index].id,
                                          );
                                        },
                                        child: MovieCarouselModel(
                                          image: movie[index]
                                              .posterPath
                                              .toString(),
                                          rating: movie[index]
                                              .voteAverage!
                                              .toDouble(),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                tvShow.isEmpty
                    ? const SizedBox()
                    : Padding(
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
                                tvShow.length <= 5
                                    ? const SizedBox()
                                    : GestureDetector(
                                        onTap: () {
                                          GoRouter.of(context).pushNamed(
                                            MyAppRouteConstants
                                                .trendingTvShowsPage,
                                            extra: state,
                                          );
                                        },
                                        child: Text(
                                          "See all",
                                          style:
                                              myTextTheme.titleSmall!.copyWith(
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        tvShow.length > 5 ? 5 : tvShow.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () =>
                                            GoRouter.of(context).pushNamed(
                                          MyAppRouteConstants.tvShowDetailsPage,
                                          extra: tvShow[index].id,
                                        ),
                                        child: MovieCarouselModel(
                                          image: tvShow[index]
                                              .posterPath
                                              .toString(),
                                          rating: tvShow[index]
                                              .voteAverage!
                                              .toDouble(),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                people.isEmpty
                    ? const SizedBox()
                    : Padding(
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
                                people.length <= 5
                                    ? const SizedBox()
                                    : GestureDetector(
                                        onTap: () {
                                          GoRouter.of(context).pushNamed(
                                            MyAppRouteConstants
                                                .trendingPeoplePage,
                                            extra: state,
                                          );
                                        },
                                        child: Text(
                                          "See all",
                                          style:
                                              myTextTheme.titleSmall!.copyWith(
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
                                  itemCount:
                                      people.length > 5 ? 5 : people.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () =>
                                          GoRouter.of(context).pushNamed(
                                        MyAppRouteConstants.peopleDetailsPage,
                                        extra: people[index].id,
                                      ),
                                      child: MovieCarouselModel(
                                        isPeople: true,
                                        image: people[index]
                                            .profilePath
                                            .toString(),
                                        rating: people[index].popularity!,
                                      ),
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
  final dynamic movie;
  final dynamic tvShow;
  const _LocalCarouselModel({
    Key? key,
    required this.loadedState,
    required this.movie,
    required this.tvShow,
  }) : super(key: key);

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
        String image = index % 2 == 0
            ? widget.movie[index].backdropPath.toString()
            : widget.tvShow[index].backdropPath.toString();
        String movieName = index % 2 == 0
            ? widget.movie[index].title.toString()
            : widget.tvShow[index].name.toString();
        String videoType = index % 2 == 0
            ? widget.movie[index].mediaType.toString()
            : widget.tvShow[index].mediaType.toString();
        String releaseDate = index % 2 == 0
            ? widget.movie[index].releaseDate!.year.toString()
            : widget.tvShow[index].firstAirDate!.year.toString();
        return Stack(alignment: Alignment.bottomCenter, children: [
          AppNetworkImage(
            image: image,
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
                                extra: widget.movie[index].id,
                              )
                            : GoRouter.of(context).pushNamed(
                                MyAppRouteConstants.tvShowDetailsPage,
                                extra: widget.tvShow[index].id,
                              );
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
