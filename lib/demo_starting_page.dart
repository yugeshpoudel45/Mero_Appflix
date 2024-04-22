// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:netflix/routes/app_route_constant.dart';

// class DemoStartingPage extends StatefulWidget {
//   const DemoStartingPage({super.key});

//   @override
//   State<DemoStartingPage> createState() => _DemoStartingPageState();
// }

// class _DemoStartingPageState extends State<DemoStartingPage> {
//   @override
//   Widget build(BuildContext context) {
//     ColorScheme myColorScheme = Theme.of(context).colorScheme;
//     Size mySize = MediaQuery.sizeOf(context);
//     TextTheme myTextTheme = Theme.of(context).textTheme;
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 log("Welcome to the World");
//                 GoRouter.of(context).pushNamed(
//                   MyAppRouteConstants.practicePage,
//                 );
//                 // GoRouter.of(context).pushNamed(
//                 //   MyAppRouteConstants.mainPage,
//                 // );
//                 // GoRouter.of(context).pushNamed(
//                 //   MyAppRouteConstants.peopleDetailsPage,
//                 //   extra: 500,
//                 // );
//                 // GoRouter.of(context).pushNamed(
//                 //   MyAppRouteConstants.tvShowDetailsPage,
//                 //   extra: 1400,
//                 // );
//               },
//               child: const Text('Login'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/cubit/search_section_cubit.dart';

import 'models/others/movie_carousel_model.dart';
import 'models/others/search_filter_model.dart';
import 'routes/app_route_constant.dart';

class DemoStartingPage extends StatefulWidget {
  const DemoStartingPage({super.key});

  @override
  State<DemoStartingPage> createState() => _DemoStartingPageState();
}

class _DemoStartingPageState extends State<DemoStartingPage> {
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
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return Scaffold(
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
                        : [1, 2, 0],
                  ),
                )
              : const Center(
                  child: Text(
                    "Search gareko xaina",
                  ),
                ),
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
          widget.result[0],
          widget.result[1] == 1
              ? true
              : (widget.result[1] == 2 ? false : false),
          widget.result[2],
        );
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    Size mySize = MediaQuery.sizeOf(context);
    TextTheme myTextTheme = Theme.of(context).textTheme;
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
        // return Column(
        //   children: [
        //     Text(state.movieSearchModel.results![0].title.toString()),
        //     Text(state.movieSearchModel.results![0].overview.toString()),
        //     Text(state.tvShowSearchModel.results![0].name.toString()),
        //     Text(state.tvShowSearchModel.results![0].overview.toString()),
        //     Text(state.peopleSearchModel.results![0].name.toString()),
        //     Text(state.peopleSearchModel.results![0].id.toString()),
        //     Text(
        //       state.peopleSearchModel.results![0].knownFor![0].overview
        //           .toString(),
        //     ),
        //   ],
        // );

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
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
                SizedBox(
                  height: mySize.height / 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    "Movies For You",
                    style: myTextTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Wrap(
                  children: List.generate(
                      2, //loadedState.trendingMovieModel.results!.length
                      (int movieIndex) {
                    var movie = state.movieSearchModel.results![movieIndex];
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
                SizedBox(
                  height: mySize.height / 40,
                ),
                Padding(
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
                      2, //loadedState.trendingMovieModel.results!.length
                      (int movieIndex) {
                    var tvShow = state.tvShowSearchModel.results![movieIndex];
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
                SizedBox(
                  height: mySize.height / 40,
                ),
                Padding(
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
                      2, //loadedState.trendingMovieModel.results!.length
                      (int movieIndex) {
                    var people = state.peopleSearchModel.results![movieIndex];
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
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
