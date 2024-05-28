import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/components/Error/error_page.dart';
import 'package:netflix/components/local_storage/watchlater_helper.dart';
import 'package:netflix/config/app_constants.dart';

import 'package:netflix/components/buttons/other_buttons/info_button.dart';
import 'package:netflix/cubit/movie_details_cubit.dart';
import 'package:netflix/models/others/animated_carousel_model.dart';
import 'package:netflix/models/others/check_rating_model.dart';
import 'package:netflix/models/others/movie_listtile_model.dart';
import 'package:netflix/models/others/readmore_model.dart';
import 'package:netflix/pages/8.movie_details/reviews_tab.dart';

import '../../../components/buttons/play_button/play_button.dart';
import '../../../models/others/movie_carousel_model.dart';
import '../../../models/others/movie_crew_model.dart';
import '../../../routes/app_route_constant.dart';
import '../../models/others/rating_model.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({
    super.key,
    required this.movieId,
  });

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailsCubit>().onFetchingMovieDetails(
          widget.movieId,
        );
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
      builder: (context, state) {
        if (state is MovieDetailsLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is MovieDetailsErrorState) {
          return Scaffold(
            body: Center(
              child: Text(state.errorMessage),
            ),
          );
        } else if (state is MovieDetailsLoadedState) {
          final movie = state.movieDetailsModel;
          List<String> allMoviePosters = [
            movie.backdropPath!,
            movie.posterPath!,
          ];
          List<String> movies = allMoviePosters
              .where((element) => element != AppConstants.placeHolderImage)
              .toList();

          String genres = "";
          for (var i = 0; i < movie.genres!.length; i++) {
            genres += movie.genres![i].name!;
            if (i != movie.genres!.length - 1) {
              genres += ", ";
            }
          }
          var crews = movie.credits!.crew!
              .where((element) =>
                  element.profilePath != AppConstants.placeHolderImage)
              .toList();
          var casts = movie.credits!.cast!
              .where((element) =>
                  element.profilePath != AppConstants.placeHolderImage)
              .toList();
          return DefaultTabController(
            length: 3,
            child: WillPopScope(
              onWillPop: () {
                GoRouter.of(context).pushReplacementNamed(
                  MyAppRouteConstants.mainPage,
                );
                return Future.value(true);
              },
              child: Scaffold(
                body: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          movies.isNotEmpty
                              ? AnimatedCarouselModel(
                                  items: movies,
                                  height: mySize.height / 2.5,
                                )
                              : SizedBox(
                                  height: mySize.height / 2.5,
                                  child: const Center(
                                    child: Text("Image Not Found"),
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: mySize.width / 1.5,
                                      child: Text(
                                        movie.title!,
                                        style: myTextTheme.headlineSmall,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Icon(Icons.share_outlined),
                                  ],
                                ),
                                SizedBox(height: mySize.height / 80),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            isScrollControlled: true,
                                            context: context,
                                            backgroundColor: Colors.transparent,
                                            builder: (context) {
                                              return RatingModal(
                                                movieId: widget.movieId,
                                                isMovie: true,
                                              );
                                            },
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            CheckRating(
                                              rating: movie.voteAverage!,
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              movie.voteAverage!
                                                  .toString()
                                                  .substring(0, 3),
                                              style: myTextTheme.labelLarge!
                                                  .copyWith(
                                                color: myColorScheme.onTertiary,
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: myColorScheme.onTertiary,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(movie.releaseDate!.year.toString()),
                                      const SizedBox(width: 8),
                                      movie.spokenLanguages!.isEmpty
                                          ? const SizedBox()
                                          : InfoButton(
                                              text: movie.spokenLanguages![0]
                                                  .englishName!,
                                              func: () {},
                                            ),
                                      const SizedBox(width: 8),
                                      movie.productionCountries!.isNotEmpty
                                          ? InfoButton(
                                              text: movie
                                                  .productionCountries![0]
                                                  .name!,
                                              func: () {},
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      PlayButton(
                                        icon: Icons.play_circle_fill_outlined,
                                        text: "Play",
                                        func: () {
                                          GoRouter.of(context).pushNamed(
                                            MyAppRouteConstants.playingPage,
                                            extra: state,
                                            pathParameters: {
                                              'movieKey': state
                                                  .movieDetailsModel
                                                  .videos!
                                                  .results![0]
                                                  .key!,
                                              'name': state.movieDetailsModel
                                                  .videos!.results![0].name!,
                                              'isMovie': 'true',
                                            },
                                          );
                                        },
                                        height: mySize.height / 16,
                                        width: mySize.width / 2.3,
                                      ),
                                      PlayButton(
                                        icon: Icons.watch_later_outlined,
                                        text: "Watch Later",
                                        func: () {
                                          Future.wait(
                                            [
                                              MyListHelper.movieExists(state
                                                      .movieDetailsModel.id
                                                      .toString())
                                                  .then(
                                                (checkMovie) {
                                                  checkMovie
                                                      ? MyListHelper
                                                          .removeFromMovieList(state
                                                              .movieDetailsModel
                                                              .id
                                                              .toString())
                                                      : MyListHelper
                                                          .addToMovieList([
                                                          state
                                                              .movieDetailsModel
                                                              .id
                                                              .toString(),
                                                          state
                                                              .movieDetailsModel
                                                              .posterPath
                                                              .toString(),
                                                        ]);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                        height: mySize.height / 16,
                                        width: mySize.width / 2.3,
                                        isFilled: false,
                                        isDownloadButton: true,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "Genre: $genres",
                                  style: myTextTheme.labelLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ReadMoreModel(
                                  text: movie.overview.toString(),
                                  textStyle: myTextTheme.bodyMedium!,
                                ),
                                SizedBox(height: mySize.height / 64),
                                crews.isEmpty
                                    ? const SizedBox()
                                    : Text("Crew",
                                        style: myTextTheme.titleMedium!),
                                crews.isEmpty
                                    ? const SizedBox()
                                    : SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: SizedBox(
                                          height: 72,
                                          child: ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: (crews.length) > 5
                                                  ? 5
                                                  : crews.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    GoRouter.of(context)
                                                        .pushNamed(
                                                      MyAppRouteConstants
                                                          .peopleDetailsPage,
                                                      extra: crews[index].id,
                                                    );
                                                  },
                                                  child: MovieCrewModel(
                                                    image: crews[index]
                                                        .profilePath
                                                        .toString(),
                                                    name: crews[index]
                                                        .name
                                                        .toString(),
                                                    role: crews[index]
                                                        .job
                                                        .toString(),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                casts.isEmpty
                                    ? const SizedBox()
                                    : Text("Cast",
                                        style: myTextTheme.titleMedium!),
                                casts.isEmpty
                                    ? const SizedBox()
                                    : SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: SizedBox(
                                          height: 72,
                                          child: ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: (casts.length) > 5
                                                  ? 5
                                                  : casts.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    GoRouter.of(context)
                                                        .pushNamed(
                                                      MyAppRouteConstants
                                                          .peopleDetailsPage,
                                                      extra: casts[index].id,
                                                    );
                                                  },
                                                  child: MovieCrewModel(
                                                    image: casts[index]
                                                        .profilePath
                                                        .toString(),
                                                    name: casts[index]
                                                        .name
                                                        .toString(),
                                                    role: casts[index]
                                                                    .knownForDepartment
                                                                    .toString() ==
                                                                "Acting" &&
                                                            casts[index]
                                                                    .gender !=
                                                                0
                                                        ? (casts[index]
                                                                    .gender ==
                                                                1
                                                            ? "Actress"
                                                            : "Actor")
                                                        : casts[index]
                                                            .knownForDepartment
                                                            .toString(),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      pinned: true,
                      floating: true,
                      snap: true,
                      toolbarHeight: 0,
                      expandedHeight: 0,
                      titleSpacing: 0,
                      collapsedHeight: 0,
                      bottom: TabBar(
                        isScrollable: true,
                        tabs: [
                          Tab(text: "Trailers"),
                          Tab(text: "More Like This"),
                          Tab(text: "Reviews"),
                        ],
                      ),
                    ),
                    SliverFillRemaining(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          //-------------------------------Movie Trailers Section-------------------------------------------
                          SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                top: 16,
                                right: 16,
                              ),
                              child: state.movieDetailsModel.videos!.results!
                                      .isEmpty
                                  ? const Center(
                                      child: ShowErrorMessage(
                                        errorMessage: "No Trailers Available!",
                                        extraInfo: "😅",
                                      ),
                                    )
                                  : Column(
                                      children: List.generate(
                                          (state.movieDetailsModel.videos!
                                                      .results!.length >
                                                  6)
                                              ? 6
                                              : state.movieDetailsModel.videos!
                                                  .results!.length, (index) {
                                        final movieVidoes =
                                            state.movieDetailsModel.videos!;
                                        return GestureDetector(
                                          onTap: () {
                                            GoRouter.of(context).pushNamed(
                                              MyAppRouteConstants.playingPage,
                                              extra: state,
                                              pathParameters: {
                                                'movieKey': movieVidoes
                                                    .results![index].key!,
                                                'name': movieVidoes
                                                    .results![index].name!,
                                                'isMovie': 'true',
                                              },
                                            );
                                          },
                                          child: MovieListTileModel(
                                            image: state.movieDetailsModel
                                                .backdropPath!,
                                            name: movieVidoes
                                                .results![index].name!,
                                            description: movieVidoes
                                                .results![index].size
                                                .toString(),
                                            date: movieVidoes.results![index]
                                                .publishedAt!.year
                                                .toString(),
                                            tag: movieVidoes
                                                .results![index].type!,
                                          ),
                                        );
                                      }),
                                    ),
                            ),
                          ),
                          // -------------------------------Similar Movies Section-------------------------------------------
                          SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                top: 16,
                                right: 8,
                                bottom: 8,
                              ),
                              child: state.movieDetailsModel.similar!.results!
                                      .isEmpty
                                  ? const Center(
                                      child: ShowErrorMessage(
                                        errorMessage:
                                            "No Similar Movies Found!!",
                                        extraInfo: "😩",
                                      ),
                                    )
                                  : Wrap(
                                      children: List.generate(6, (int index) {
                                        var movie = state
                                            .movieDetailsModel.similar!.results!
                                            .where((element) =>
                                                element.posterPath !=
                                                AppConstants.placeHolderImage)
                                            .toList();
                                        return GestureDetector(
                                          onTap: () {
                                            GoRouter.of(context).pushNamed(
                                              MyAppRouteConstants
                                                  .movieDetailsPage,
                                              extra: movie[index].id,
                                            );
                                          },
                                          child: MovieCarouselModel(
                                            width: mySize.width / 2.25,
                                            height: mySize.height / 3.2,
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
                          ),
                          //-----------------------------Movie Reviews Tab here----------------------------------
                          ReviewsTab(state: state),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
