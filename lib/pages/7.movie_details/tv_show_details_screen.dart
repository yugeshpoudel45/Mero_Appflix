import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/pages/7.movie_details/reviews_tab.dart';

import '../../components/buttons/other_buttons/info_button.dart';
import '../../components/buttons/play_button/play_button.dart';
import '../../cubit/tv_show_details_cubit.dart';
import '../../models/For APIs/tv_show_details_model.dart';
import '../../models/others/animated_carousel_model.dart';
import '../../models/others/movie_carousel_model.dart';
import '../../models/others/movie_crew_model.dart';
import '../../models/others/movie_listtile_model.dart';
import '../../models/others/readmore_model.dart';
import '../../routes/app_route_constant.dart';

class TvShowDetailsScreen extends StatefulWidget {
  final int movieId;
  const TvShowDetailsScreen({super.key, required this.movieId});

  @override
  State<TvShowDetailsScreen> createState() => _TvShowDetailsScreenState();
}

class _TvShowDetailsScreenState extends State<TvShowDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TvShowDetailsCubit>().onFetchingTvShowDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return BlocBuilder<TvShowDetailsCubit, TvShowDetailsState>(
      builder: (context, state) {
        if (state is TvShowDetailsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvShowDetailsErrorState) {
          return Scaffold(
            body: Center(
              child: Text(state.errorMessage),
            ),
          );
        } else if (state is TvShowDetailsLoadedState) {
          final movie = state.tvShowDetailsModel;
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
                        AnimatedCarouselModel(
                          items: movies,
                          height: mySize.height / 2.5,
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
                                      movie.name!,
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
                                    Text(movie.firstAirDate!.year.toString()),
                                    movie.spokenLanguages!.isEmpty
                                        ? const SizedBox()
                                        : const SizedBox(width: 8),
                                    movie.spokenLanguages!.isEmpty
                                        ? const SizedBox()
                                        : InfoButton(
                                            text: movie.spokenLanguages![0]
                                                .englishName!,
                                            func: () {},
                                          ),
                                    movie.productionCountries!.isEmpty
                                        ? const SizedBox()
                                        : const SizedBox(width: 8),
                                    movie.productionCountries!.isEmpty
                                        ? const SizedBox()
                                        : InfoButton(
                                            text: movie
                                                .productionCountries![0].name!,
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
                                          MyAppRouteConstants.playingPage,
                                          extra: state,
                                          pathParameters: {
                                            'movieKey': state.tvShowDetailsModel
                                                .videos!.results![0].key!,
                                            'name': state.tvShowDetailsModel
                                                .videos!.results![0].name!,
                                            "isMovie": "false",
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
                              movie.credits!.crew!.isEmpty
                                  ? const SizedBox()
                                  : Text("Crew",
                                      style: myTextTheme.titleMedium!),
                              movie.credits!.crew!.isEmpty
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
                                          itemCount:
                                              (movie.credits!.crew!.length) > 5
                                                  ? 5
                                                  : movie.credits!.crew!.length,
                                          itemBuilder: (context, index) {
                                            final movieCredits = movie.credits!;
                                            return MovieCrewModel(
                                              image: movieCredits
                                                  .crew![index].profilePath
                                                  .toString(),
                                              name: movieCredits
                                                  .crew![index].name
                                                  .toString(),
                                              role: _checkDepartment(
                                                  movieCredits.crew![index]
                                                      .knownForDepartment!),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                              movie.credits!.cast!.isEmpty
                                  ? const SizedBox()
                                  : Text("Cast",
                                      style: myTextTheme.titleMedium!),
                              movie.credits!.cast!.isEmpty
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
                                            itemCount: (movie.credits!.cast!
                                                        .length) >
                                                    5
                                                ? 5
                                                : movie.credits!.cast!.length,
                                            itemBuilder: (context, index) {
                                              final movieCredits =
                                                  movie.credits!;
                                              return MovieCrewModel(
                                                image: movieCredits
                                                    .cast![index].profilePath
                                                    .toString(),
                                                name: movieCredits
                                                    .cast![index].name
                                                    .toString(),
                                                role: _checkDepartment(
                                                    movieCredits.cast![index]
                                                        .knownForDepartment!),
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
                            child: state
                                    .tvShowDetailsModel.videos!.results!.isEmpty
                                ? const Center(
                                    child: Text(
                                      "No Trailers Available!",
                                    ),
                                  )
                                : Column(
                                    children: List.generate(
                                        (state.tvShowDetailsModel.videos!
                                                    .results!.length >
                                                6)
                                            ? 6
                                            : state.tvShowDetailsModel.videos!
                                                .results!.length, (index) {
                                      final movieVidoes =
                                          state.tvShowDetailsModel.videos!;
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
                                              'isMovie': 'false',
                                            },
                                          );
                                        },
                                        child: MovieListTileModel(
                                          image: state
                                              .tvShowDetailsModel.backdropPath!,
                                          name:
                                              movieVidoes.results![index].name!,
                                          description: movieVidoes
                                              .results![index].size
                                              .toString(),
                                          date: movieVidoes
                                              .results![index].publishedAt!.year
                                              .toString(),
                                          tag:
                                              movieVidoes.results![index].type!,
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
                            child: state
                                    .tvShowDetailsModel.similar!.results!.isEmpty
                                ? const Center(
                                    child: Text(
                                      "No Similar Movies Available!",
                                    ),
                                  )
                                : Wrap( 
                              children: List.generate(6, (int movieIndex) {
                                var similarMovies = state.tvShowDetailsModel
                                    .similar!.results![movieIndex];
                                return similarMovies.posterPath.toString() ==
                                        "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png"
                                    ? const SizedBox()
                                    : GestureDetector(
                                        onTap: () {
                                          GoRouter.of(context).pushNamed(
                                            MyAppRouteConstants
                                                .tvShowDetailsPage,
                                            extra: similarMovies.id,
                                          );
                                        },
                                        child: MovieCarouselModel(
                                          width: mySize.width / 2.25,
                                          height: mySize.height / 3.2,
                                          image: similarMovies.posterPath
                                              .toString(),
                                          rating: similarMovies.popularity!,
                                        ),
                                      );
                              }),
                            ),
                          ),
                        ),
                        //-----------------------------Movie Reviews Tab here----------------------------------
                        ReviewsTab(
                          state: state,
                          isMovie: false,
                        ),
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

String _checkDepartment(Department value) {
  switch (value) {
    case Department.ACTING:
      return "Actor";
    case Department.WRITING:
      return "Writer";
    case Department.PRODUCTION:
      return "Producer";
    case Department.DIRECTING:
      return "Director";
    default:
      return "Support Role";
  }
}
