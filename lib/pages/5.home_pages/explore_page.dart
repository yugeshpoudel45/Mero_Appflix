import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/cubit/search_section_cubit.dart';

import '../../cubit/trending_section_cubit.dart';
import '../../models/others/movie_carousel_model.dart';
import '../../models/others/movie_listtile_model.dart';
import '../../models/others/search_filter_model.dart';
import '../../routes/app_route_constant.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController _searchController = TextEditingController();

  bool tapped = false;
  List<int>? result = [];
  String searchedText = "";
  bool searched = false;

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    Size mySize = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: mySize.height / 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: mySize.height / 12,
                  width: mySize.width / 1.4,
                  child: CupertinoSearchTextField(
                    autofocus: true,
                    controller: _searchController,
                    prefixInsets: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                        color: myColorScheme.onInverseSurface,
                        borderRadius: BorderRadius.circular(12),
                        border: tapped == true
                            ? Border.all(
                                color: Colors.red,
                                width: 1.5,
                              )
                            : Border.all(
                                color: Colors.transparent,
                              )),
                    onTap: () {
                      setState(() {
                        tapped = !tapped;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          searched = false;
                        }
                      });
                    },
                    onSuffixTap: () {
                      _searchController.clear();
                      setState(() {
                        searchedText = "";
                      });
                      searched = false;
                    },
                    onSubmitted: (value) {
                      setState(() {
                        searchedText = value;
                        searched = true;
                      });
                    },
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: myColorScheme.secondaryContainer,
                    padding: const EdgeInsets.all(18),
                    shape: RoundedRectangleBorder(
                      side: result == null ||
                              result!.isEmpty ||
                              (result![0] == 0 &&
                                  result![1] == 0 &&
                                  result![2] == 0)
                          ? BorderSide.none
                          : BorderSide(
                              color: myColorScheme.onTertiary,
                              width: 1.5,
                            ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    result = await showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return const SearchFilterModal();
                      },
                    );
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.tune_rounded,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: mySize.height / 64,
          ),
          searched == true
              ? Expanded(
                  child: _ActualSearchScreen(
                    searchedText: searchedText,
                    result: result != null && result!.isNotEmpty
                        ? result!
                        : [1, 2, -1],
                  ),
                )
              : const _SearchPagePlaceHolder()
        ],
      ),
    );
  }
}

class _ActualSearchScreen extends StatefulWidget {
  final String searchedText;
  final List<int> result;
  const _ActualSearchScreen({
    required this.result,
    required this.searchedText,
  });

  @override
  State<_ActualSearchScreen> createState() => __ActualSearchScreenState();
}

class __ActualSearchScreenState extends State<_ActualSearchScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SearchSectionCubit>().onFetchingSearchSection(
          widget.searchedText,
          widget.result[1] == 1
              ? true
              : (widget.result[1] == 2 ? false : false),
          widget.result[2],
        );
  }

  @override
  Widget build(BuildContext context) {
    Size mySize = MediaQuery.sizeOf(context);
    TextTheme myTextTheme = Theme.of(context).textTheme;
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<SearchSectionCubit, SearchSectionState>(
        builder: (context, state) {
      if (state is SearchSectionLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is SearchSectionErrorState) {
        return Center(
          child: Text(state.errorMessage),
        );
      } else if (state is SearchSectionLoadedState) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: widget.result[2] == -1
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: Text(
                          "*Use the search filter to get more accurate results*",
                          textAlign: TextAlign.center,
                          style: myTextTheme.labelSmall!.copyWith(
                            color: Colors.green,
                          ),
                        ),
                      ),
                      state.movieSearchModel.results!.isEmpty &&
                              state.tvShowSearchModel.results!.isEmpty &&
                              state.peopleSearchModel.results!.isEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: mySize.height / 3,
                                ),
                                Center(
                                  child: Text(
                                    "No Results Found!!",
                                    style: myTextTheme.headlineSmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: myColorScheme.onTertiary,
                                    ),
                                  ),
                                ),
                                const Center(
                                  child: Text(
                                    "Sorry, the keyword you entered could not be found. Please try again with a different keyword.",
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      state.movieSearchModel.results!.isEmpty
                          ? const SizedBox()
                          : SizedBox(
                              height: mySize.height / 100,
                            ),
                      state.movieSearchModel.results!.isEmpty
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                "Movies For You",
                                style: myTextTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                      state.movieSearchModel.results!.isEmpty
                          ? const SizedBox()
                          : Wrap(
                              children: List.generate(
                                  state.movieSearchModel.results!.length < 2
                                      ? state.movieSearchModel.results!.length
                                      : 2, (int movieIndex) {
                                var movie =
                                    state.movieSearchModel.results![movieIndex];
                                return GestureDetector(
                                  onTap: () {
                                    GoRouter.of(context).pushNamed(
                                      MyAppRouteConstants.movieDetailsPage,
                                      extra: movie.id,
                                    );
                                  },
                                  child: MovieCarouselModel(
                                    width: mySize.width / 2.25,
                                    height: mySize.height / 3.2,
                                    image: movie.posterPath.toString(),
                                    rating: movie.popularity!,
                                  ),
                                );
                              }),
                            ),
                      state.tvShowSearchModel.results!.isEmpty
                          ? const SizedBox()
                          : SizedBox(
                              height: mySize.height / 40,
                            ),
                      state.tvShowSearchModel.results!.isEmpty
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                "Tv Shows For You",
                                style: myTextTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                      Wrap(
                        children: List.generate(
                            state.tvShowSearchModel.results!.length < 2
                                ? state.tvShowSearchModel.results!.length
                                : 2, (int movieIndex) {
                          var tvShow =
                              state.tvShowSearchModel.results![movieIndex];
                          return GestureDetector(
                            onTap: () {
                              GoRouter.of(context).pushNamed(
                                MyAppRouteConstants.tvShowDetailsPage,
                                extra: tvShow.id,
                              );
                            },
                            child: MovieCarouselModel(
                              width: mySize.width / 2.25,
                              height: mySize.height / 3.2,
                              image: tvShow.posterPath.toString(),
                              rating: tvShow.popularity!,
                            ),
                          );
                        }),
                      ),
                      state.peopleSearchModel.results!.isEmpty
                          ? const SizedBox()
                          : SizedBox(
                              height: mySize.height / 40,
                            ),
                      state.peopleSearchModel.results!.isEmpty
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                "Celebrities For You",
                                style: myTextTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                      Wrap(
                        children: List.generate(
                            state.peopleSearchModel.results!.length < 2
                                ? state.peopleSearchModel.results!.length
                                : 2, (int movieIndex) {
                          var people =
                              state.peopleSearchModel.results![movieIndex];
                          return GestureDetector(
                            onTap: () {
                              GoRouter.of(context).pushNamed(
                                MyAppRouteConstants.peopleDetailsPage,
                                extra: people.id,
                              );
                            },
                            child: MovieCarouselModel(
                              width: mySize.width / 2.25,
                              height: mySize.height / 3.2,
                              image: people.profilePath.toString(),
                              rating: people.popularity!,
                            ),
                          );
                        }),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: mySize.height / 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: widget.result[0] == 1
                            ? state.movieSearchModel.results!.isEmpty
                                ? const Center(child: Text("Movie not Found"))
                                : Text("Movies For You",
                                    style: myTextTheme.headlineSmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ))
                            : widget.result[0] == 2
                                ? state.tvShowSearchModel.results!.isEmpty
                                    ? const Center(
                                        child: Text("Tv Show not Found"))
                                    : Text("Tv Shows For You",
                                        style:
                                            myTextTheme.headlineSmall!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ))
                                : state.peopleSearchModel.results!.isEmpty
                                    ? const Center(
                                        child: Text("Celebrity not Found"))
                                    : widget.result[0] == 3
                                        ? Text(
                                            "Celebrities For You",
                                            style: myTextTheme.headlineSmall!
                                                .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        : const SizedBox(),
                      ),
                      Wrap(
                        children: List.generate(
                            widget.result[0] == 1
                                ? state.movieSearchModel.results!.length < 10
                                    ? state.movieSearchModel.results!.length
                                    : 10
                                : widget.result[0] == 2
                                    ? state.tvShowSearchModel.results!.length <
                                            10
                                        ? state
                                            .tvShowSearchModel.results!.length
                                        : 10
                                    : widget.result[0] == 3
                                        ? state.peopleSearchModel.results!
                                                    .length <
                                                10
                                            ? state.peopleSearchModel.results!
                                                .length
                                            : 10
                                        : 0, (int movieIndex) {
                          var movie =
                              state.movieSearchModel.results![movieIndex];
                          var tvShow =
                              state.tvShowSearchModel.results![movieIndex];
                          var people =
                              state.peopleSearchModel.results![movieIndex];

                          return widget.result[0] == 1
                              ? GestureDetector(
                                  onTap: () {
                                    GoRouter.of(context).pushNamed(
                                      MyAppRouteConstants.movieDetailsPage,
                                      extra: movie.id,
                                    );
                                  },
                                  child: MovieCarouselModel(
                                    width: mySize.width / 2.25,
                                    height: mySize.height / 3.2,
                                    image: movie.posterPath.toString(),
                                    rating: movie.popularity!,
                                  ),
                                )
                              : widget.result[0] == 2
                                  ? GestureDetector(
                                      onTap: () {
                                        GoRouter.of(context).pushNamed(
                                          MyAppRouteConstants.tvShowDetailsPage,
                                          extra: tvShow.id,
                                        );
                                      },
                                      child: MovieCarouselModel(
                                        width: mySize.width / 2.25,
                                        height: mySize.height / 3.2,
                                        image: tvShow.posterPath.toString(),
                                        rating: tvShow.popularity!,
                                      ),
                                    )
                                  : widget.result[0] == 3
                                      ? GestureDetector(
                                          onTap: () {
                                            GoRouter.of(context).pushNamed(
                                              MyAppRouteConstants
                                                  .peopleDetailsPage,
                                              extra: people.id,
                                            );
                                          },
                                          child: MovieCarouselModel(
                                            width: mySize.width / 2.25,
                                            height: mySize.height / 3.2,
                                            image:
                                                people.profilePath.toString(),
                                            rating: people.popularity!,
                                          ),
                                        )
                                      : const Center(
                                          child: Text("Error Occured"),
                                        );
                        }),
                      ),
                    ],
                  ),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}

class _SearchPagePlaceHolder extends StatefulWidget {
  const _SearchPagePlaceHolder();

  @override
  State<_SearchPagePlaceHolder> createState() => _SearchPagePlaceHolderState();
}

class _SearchPagePlaceHolderState extends State<_SearchPagePlaceHolder> {
  @override
  void initState() {
    super.initState();
    context.read<TrendingSectionCubit>().onFetchingTrendingSection();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Text(
                  "Top Searches",
                  style: myTextTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: List.generate(4, (int index) {
                  var fetchMovieResult =
                      state.trendingMovieModel.results![index];
                  var fetchTvShowResult =
                      state.trendingTvShowModel.results![index];
                  String image = index % 2 == 0
                      ? fetchMovieResult.posterPath.toString()
                      : fetchTvShowResult.posterPath.toString();
                  String movieName = index % 2 == 0
                      ? fetchMovieResult.title.toString()
                      : fetchTvShowResult.name.toString();
                  String type = index % 2 == 0 ? "Movie" : "Tv Show";
                  String releaseDate = index % 2 == 0
                      ? fetchMovieResult.releaseDate!.year.toString()
                      : fetchTvShowResult.firstAirDate!.year.toString();
                  return GestureDetector(
                    onTap: () => index % 2 == 0
                        ? GoRouter.of(context).pushNamed(
                            MyAppRouteConstants.movieDetailsPage,
                            extra: fetchMovieResult.id,
                          )
                        : GoRouter.of(context).pushNamed(
                            MyAppRouteConstants.tvShowDetailsPage,
                            extra: fetchTvShowResult.id,
                          ),
                    child: MovieListTileModel(
                      image: image,
                      name: movieName,
                      description: "",
                      date: releaseDate,
                      tag: type,
                    ),
                  );
                }),
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
