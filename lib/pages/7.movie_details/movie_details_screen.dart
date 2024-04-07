import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:netflix/components/buttons/other_buttons/info_button.dart';
import 'package:netflix/cubit/movie_details_cubit.dart';
import 'package:netflix/models/others/animated_carousel_model.dart';
import 'package:netflix/models/others/movie_listtile_model.dart';
import 'package:netflix/models/others/readmore_model.dart';

import '../../components/buttons/play_button/play_button.dart';
import '../../models/others/movie_carousel_model.dart';
import '../../models/others/movie_crew_model.dart';
import '../../models/others/movie_reviews_model.dart';
import '../../routes/app_route_constant.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailsCubit>().onFetchingMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
      builder: (context, state) {
        if (state is MovieDetailsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieDetailsErrorState) {
          return Scaffold(
            body: Center(
              child: Text(state.errorMessage),
            ),
          );
        } else if (state is MovieDetailsLoadedState) {
          final movie = state.movieDetailsModel;
          List<String> movies = [
            movie.backdropPath!,
            movie.posterPath!,
          ];
          String genres = "";
          for (var i = 0; i < movie.genres!.length; i++) {
            genres += movie.genres![i].name!;
            if (i != movie.genres!.length - 1) {
              genres += ", ";
            }
          }
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        AnimatedCarouselModel(items: movies),
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
                                      style: myTextTheme.headlineSmall!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star_half_rounded,
                                      color: myColorScheme.onTertiary,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      movie.popularity.toString(),
                                      style: myTextTheme.labelLarge!.copyWith(
                                        color: myColorScheme.onTertiary,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: myColorScheme.onTertiary,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(movie.releaseDate!.year.toString()),
                                    const SizedBox(width: 8),
                                    InfoButton(
                                      text: movie
                                          .spokenLanguages![0].englishName!,
                                      func: () {},
                                    ),
                                    const SizedBox(width: 8),
                                    InfoButton(
                                      text: movie.productionCountries![0].name!,
                                      func: () {},
                                    ),
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
                                          MyAppRouteConstants.moviePlayingPage,
                                          extra: state,
                                          pathParameters: {
                                            'movieKey': state.movieDetailsModel
                                                .videos!.results![0].key!,
                                            'name': state.movieDetailsModel
                                                .videos!.results![0].name!,
                                          },
                                        );
                                      },
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
                              Text("Crew", style: myTextTheme.titleMedium!),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  height: 72,
                                  child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        final movieCredits = movie.credits!;
                                        return MovieCrewModel(
                                          image: movieCredits
                                              .crew![index].profilePath
                                              .toString(),
                                          name: movieCredits.crew![index].name
                                              .toString(),
                                          role: movieCredits.crew![index].job
                                              .toString(),
                                        );
                                      }),
                                ),
                              ),
                              Text("Cast", style: myTextTheme.titleMedium!),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  height: 72,
                                  child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        final movieCredits = movie.credits!;
                                        return MovieCrewModel(
                                          image: movieCredits
                                              .cast![index].profilePath
                                              .toString(),
                                          name: movieCredits.cast![index].name
                                              .toString(),
                                          role: movieCredits.cast![index]
                                                          .knownForDepartment
                                                          .toString() ==
                                                      "Acting" &&
                                                  movieCredits.cast![index]
                                                          .gender !=
                                                      0
                                              ? (movieCredits.cast![index]
                                                          .gender ==
                                                      1
                                                  ? "Actress"
                                                  : "Actor")
                                              : movieCredits.cast![index]
                                                  .knownForDepartment
                                                  .toString(),
                                          // role: movieCredits.cast![index]
                                          //     .gender == 1 ? "Actor" : "Actress",
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
                    //!Issue: While Scrolling tabbarView is going inside the tab bar in flutter
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
                            child: Column(
                              children: List.generate(
                                  (state.movieDetailsModel.videos!.results!
                                              .length >
                                          6)
                                      ? 6
                                      : state.movieDetailsModel.videos!.results!
                                          .length, (index) {
                                final movieVidoes =
                                    state.movieDetailsModel.videos!;
                                return GestureDetector(
                                  onTap: () {
                                    GoRouter.of(context).pushNamed(
                                      MyAppRouteConstants.moviePlayingPage,
                                      extra: state,
                                      pathParameters: {
                                        'movieKey':
                                            movieVidoes.results![index].key!,
                                        'name':
                                            movieVidoes.results![index].name!,
                                      },
                                    );
                                  },
                                  child: MovieListTileModel(
                                    image:
                                        state.movieDetailsModel.backdropPath!,
                                    name: movieVidoes.results![index].name!,
                                    description: movieVidoes
                                        .results![index].size
                                        .toString(),
                                    date: movieVidoes
                                        .results![index].publishedAt!.year
                                        .toString(),
                                    tag: movieVidoes.results![index].type!,
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
                            child: Wrap(
                              children: List.generate(6, (int movieIndex) {
                                var similarMovies = state.movieDetailsModel
                                    .similar!.results![movieIndex];
                                return GestureDetector(
                                  onTap: () {
                                    GoRouter.of(context).pushNamed(
                                      MyAppRouteConstants.movieDetailsPage,
                                      extra: similarMovies.id,
                                    );
                                  },
                                  child: MovieCarouselModel(
                                    width: mySize.width / 2.25,
                                    height: mySize.height / 3.2,
                                    image: similarMovies.posterPath.toString(),
                                    rating: similarMovies.popularity!,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        //-----------------------------Movie Reviews Tab here----------------------------------
                        _ReviewsTab(state: state),
                      ],
                    ),
                  ),
                ],
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

//-----------------------------Movie Reviews Section----------------------------------
class _ReviewsTab extends StatelessWidget {
  const _ReviewsTab({
    required this.state,
  });

  final MovieDetailsLoadedState state;

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 16,
          right: 16,
        ),
        child: state.movieDetailsModel.reviews!.results!.isEmpty
            ? const Center(
                child: Text("No Reviews given yet!"),
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Reviews",
                        style: myTextTheme.titleLarge!.copyWith(
                          fontFamily: GoogleFonts.balsamiqSans().fontFamily!,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).pushNamed(
                            MyAppRouteConstants.movieReviewsPage,
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
                  Column(
                    children: List.generate(1, (index) {
                      final movieReviews = state.movieDetailsModel.reviews!;
                      return MovieReviewsModel(
                        avatar: movieReviews
                            .results![index].authorDetails!.avatarPath!,
                        name: movieReviews.results![index].author!,
                        userName: movieReviews
                            .results![index].authorDetails!.username!,
                        rating:
                            movieReviews.results![index].authorDetails!.rating!,
                        comment: movieReviews.results![index].content!,
                        datetime: movieReviews.results![index].createdAt!,
                      );
                    }),
                  ),
                ],
              ),
      ),
    );
  }
}
