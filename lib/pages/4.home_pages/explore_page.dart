import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/cubit/search_section_cubit.dart';
import 'package:netflix/config/app_constants.dart';

import '../../components/Error/error_page.dart';
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

  // @override
  // void dispose() {
  //   super.dispose();
  //   _searchController.dispose();
  // }

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
                    // autofocus: true,
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
                        // if (value.isEmpty) {
                        //   searched = false;
                        // }
                        searched = false;
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
                      if (value.isEmpty) {
                        return;
                      }
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
                    searchedText = _searchController.text;
                    if (result == null) {
                      searched = false;
                      _searchController.clear();
                    } else if (result!.isEmpty) {
                      searched = false;
                      _searchController.clear();
                    } else if (result![0] == 0 &&
                        result![1] == 0 &&
                        result![2] == 0) {
                      searched = false;
                      _searchController.clear();
                    } else {
                      searched = true;
                    }
                    // result!.isNotEmpty ? searched = true : searched = false;
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
                    result: result == null
                        ? [1, 2, -1]
                        : result!.isNotEmpty
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
    return BlocBuilder<SearchSectionCubit, SearchSectionState>(
        builder: (context, state) {
      if (state is SearchSectionLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is SearchSectionErrorState) {
        return ShowErrorMessage(
          errorMessage: state.errorMessage,
          extraInfo: "😞",
        );
      } else if (state is SearchSectionLoadedState) {
        var movie = state.movieSearchModel.results!
            .where((element) =>
                element.posterPath != AppConstants.placeHolderImage)
            .toList();
        var tvShow = state.tvShowSearchModel.results!
            .where((element) =>
                element.posterPath != AppConstants.placeHolderImage)
            .toList();
        var people = state.peopleSearchModel.results!
            .where((element) =>
                element.profilePath != AppConstants.placeHolderImage)
            .toList();
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
                      movie.isEmpty && tvShow.isEmpty && people.isEmpty
                          ? const ShowErrorMessage()
                          : const SizedBox(),
                      movie.isEmpty
                          ? const SizedBox()
                          : SizedBox(
                              height: mySize.height / 100,
                            ),
                      movie.isEmpty
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
                      movie.isEmpty
                          ? const SizedBox()
                          : Wrap(
                              children: List.generate(
                                  movie.length < 2 ? movie.length : 2,
                                  (int movieIndex) {
                                var movie1 = movie[movieIndex];
                                return GestureDetector(
                                  onTap: () {
                                    GoRouter.of(context).pushNamed(
                                      MyAppRouteConstants.movieDetailsPage,
                                      extra: movie1.id,
                                    );
                                  },
                                  child: MovieCarouselModel(
                                    width: mySize.width / 2.25,
                                    height: mySize.height / 3.2,
                                    image: movie1.posterPath.toString(),
                                    rating: movie1.voteAverage!.toDouble(),
                                  ),
                                );
                              }),
                            ),
                      tvShow.isEmpty
                          ? const SizedBox()
                          : SizedBox(
                              height: mySize.height / 40,
                            ),
                      tvShow.isEmpty
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
                        children:
                            List.generate(tvShow.length < 2 ? tvShow.length : 2,
                                (int movieIndex) {
                          var tvShow1 = tvShow[movieIndex];
                          return GestureDetector(
                            onTap: () {
                              GoRouter.of(context).pushNamed(
                                MyAppRouteConstants.tvShowDetailsPage,
                                extra: tvShow1.id,
                              );
                            },
                            child: MovieCarouselModel(
                              width: mySize.width / 2.25,
                              height: mySize.height / 3.2,
                              image: tvShow1.posterPath.toString(),
                              rating: tvShow1.voteAverage!.toDouble(),
                            ),
                          );
                        }),
                      ),
                      people.isEmpty
                          ? const SizedBox()
                          : SizedBox(
                              height: mySize.height / 40,
                            ),
                      people.isEmpty
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
                        children:
                            List.generate(people.length < 2 ? people.length : 2,
                                (int movieIndex) {
                          var people1 = people[movieIndex];
                          return GestureDetector(
                            onTap: () {
                              GoRouter.of(context).pushNamed(
                                MyAppRouteConstants.peopleDetailsPage,
                                extra: people1.id,
                              );
                            },
                            child: MovieCarouselModel(
                              isPeople: true,
                              width: mySize.width / 2.25,
                              height: mySize.height / 3.2,
                              image: people1.profilePath.toString(),
                              rating: people1.popularity!,
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
                            ? movie.isEmpty
                                ? const ShowErrorMessage(
                                    errorMessage: "Movie not Found")
                                : Text("Movies For You",
                                    style: myTextTheme.headlineSmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ))
                            : widget.result[0] == 2
                                ? tvShow.isEmpty
                                    ? const ShowErrorMessage(
                                        errorMessage: "Tv Show not Found")
                                    : Text("Tv Shows For You",
                                        style:
                                            myTextTheme.headlineSmall!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ))
                                : people.isEmpty
                                    ? const ShowErrorMessage(
                                        errorMessage: "People not Found")
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
                                ? movie.length < 10
                                    ? movie.length
                                    : 10
                                : widget.result[0] == 2
                                    ? tvShow.length < 10
                                        ? tvShow.length
                                        : 10
                                    : widget.result[0] == 3
                                        ? people.length < 10
                                            ? people.length
                                            : 10
                                        : 0, (int movieIndex) {
                          return widget.result[0] == 1
                              ? movie.isEmpty
                                  ? const SizedBox()
                                  : GestureDetector(
                                      onTap: () {
                                        GoRouter.of(context).pushNamed(
                                          MyAppRouteConstants.movieDetailsPage,
                                          extra: movie[movieIndex].id,
                                        );
                                      },
                                      child: MovieCarouselModel(
                                        width: mySize.width / 2.25,
                                        height: mySize.height / 3.2,
                                        image: movie[movieIndex]
                                            .posterPath
                                            .toString(),
                                        rating: movie[movieIndex]
                                            .voteAverage!
                                            .toDouble(),
                                      ),
                                    )
                              : widget.result[0] == 2
                                  ? tvShow.isEmpty
                                      ? const SizedBox()
                                      : GestureDetector(
                                          onTap: () {
                                            GoRouter.of(context).pushNamed(
                                              MyAppRouteConstants
                                                  .tvShowDetailsPage,
                                              extra: tvShow[movieIndex].id,
                                            );
                                          },
                                          child: MovieCarouselModel(
                                            width: mySize.width / 2.25,
                                            height: mySize.height / 3.2,
                                            image: tvShow[movieIndex]
                                                .posterPath
                                                .toString(),
                                            rating: tvShow[movieIndex]
                                                .voteAverage!
                                                .toDouble(),
                                          ),
                                        )
                                  : widget.result[0] == 3
                                      ? people.isEmpty
                                          ? const SizedBox()
                                          : GestureDetector(
                                              onTap: () {
                                                GoRouter.of(context).pushNamed(
                                                  MyAppRouteConstants
                                                      .peopleDetailsPage,
                                                  extra: people[movieIndex].id,
                                                );
                                              },
                                              child: MovieCarouselModel(
                                                isPeople: true,
                                                width: mySize.width / 2.25,
                                                height: mySize.height / 3.2,
                                                image: people[movieIndex]
                                                    .profilePath
                                                    .toString(),
                                                rating: people[movieIndex]
                                                    .popularity!,
                                              ),
                                            )
                                      : const ShowErrorMessage();
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
        return ShowErrorMessage(
          errorMessage: state.errorMessage,
          extraInfo: "😞",
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
                  String image = index % 2 == 0
                      ? movie[index].posterPath.toString()
                      : tvShow[index].posterPath.toString();
                  String movieName = index % 2 == 0
                      ? movie[index].title.toString()
                      : tvShow[index].name.toString();
                  String type = index % 2 == 0 ? "Movie" : "Tv Show";
                  String releaseDate = index % 2 == 0
                      ? movie[index].releaseDate!.year.toString()
                      : tvShow[index].firstAirDate!.year.toString();
                  return GestureDetector(
                    onTap: () => index % 2 == 0
                        ? GoRouter.of(context).pushNamed(
                            MyAppRouteConstants.movieDetailsPage,
                            extra: movie[index].id,
                          )
                        : GoRouter.of(context).pushNamed(
                            MyAppRouteConstants.tvShowDetailsPage,
                            extra: tvShow[index].id,
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
