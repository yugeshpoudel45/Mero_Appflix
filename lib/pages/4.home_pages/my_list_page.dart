import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/components/Error/error_page.dart';
import 'package:netflix/components/buttons/other_buttons/choosing_button.dart';
import 'package:netflix/components/local_storage/watchlater_helper.dart';
import 'package:netflix/models/others/movie_carousel_model.dart';

import '../../config/app_local_assets.dart';
import '../../routes/app_route_constant.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({super.key});

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  int _selectCategory = 0;
  late Future<List<dynamic>> _storedDataFuture;

  @override
  void initState() {
    super.initState();
    _storedDataFuture = getStoredData();
  }

  Future<List<dynamic>> getStoredData() async {
    try {
      return Future.wait([
        MyListHelper.getMovieList(),
        MyListHelper.getTvShowList(),
      ]);
    } catch (e) {
      log('Error fetching stored data: $e');
      rethrow;
    }
  }

  void _selectCategoryPressed(int value) {
    setState(() {
      _selectCategory = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);

    return FutureBuilder<List<dynamic>>(
      future: _storedDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
            ),
          );
        } else if (snapshot.hasData) {
          List<List<String>> movieList = snapshot.data![0];
          List<List<String>> tvList = snapshot.data![1];
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                    left: 16,
                    right: 16,
                    bottom: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppAssets.appLogo,
                            height: mySize.height / 24,
                          ),
                          SizedBox(
                            width: mySize.width / 32,
                          ),
                          Text(
                            "My List",
                            style: myTextTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Clear List"),
                                content: const Text(
                                    "Are you sure you want to clear your list?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      MyListHelper.clearMovieList();
                                      MyListHelper.clearTvShowList();
                                      setState(() {
                                        _storedDataFuture = getStoredData();
                                      });
                                      Fluttertoast.showToast(
                                        msg: 'List Cleared!',
                                        backgroundColor: Colors.red,
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Yes"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("No"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.delete,
                          color: myColorScheme.onTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChoosingItemButton(
                        text: "All Categories",
                        buttonPressed: () {
                          _selectCategoryPressed(0);
                        },
                        isFilled: _selectCategory == 0 ? true : false,
                      ),
                      ChoosingItemButton(
                        text: "Movie",
                        buttonPressed: () {
                          _selectCategoryPressed(1);
                        },
                        isFilled: _selectCategory == 1 ? true : false,
                      ),
                      ChoosingItemButton(
                        text: "Tv Show",
                        buttonPressed: () {
                          _selectCategoryPressed(2);
                        },
                        isFilled: _selectCategory == 2 ? true : false,
                      ),
                    ],
                  ),
                ),
                _selectCategory == 0
                    ? movieList[0].isEmpty && tvList[0].isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: ShowErrorMessage(
                                errorMessage: "Your List is Empty",
                                extraInfo:
                                    "It seems that you haven't added any Movies or Tv Shows to the list.",
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              top: 16,
                              right: 8,
                              bottom: 8,
                            ),
                            child: Wrap(
                              children: List.generate(
                                  movieList[0].length + tvList[0].length,
                                  (int movieIndex) {
                                bool isMovie = movieIndex < movieList[0].length;
                                return GestureDetector(
                                  onTap: () {
                                    isMovie
                                        ? GoRouter.of(context).pushNamed(
                                            MyAppRouteConstants
                                                .movieDetailsPage,
                                            extra: int.parse(
                                                movieList[0][movieIndex]),
                                          )
                                        : GoRouter.of(context).pushNamed(
                                            MyAppRouteConstants
                                                .tvShowDetailsPage,
                                            extra: int.parse(tvList[0][
                                                movieIndex -
                                                    movieList[0].length]),
                                          );
                                  },
                                  child: MovieCarouselModel(
                                    width: mySize.width / 2.25,
                                    height: mySize.height / 3.2,
                                    image: isMovie
                                        ? movieList[1][movieIndex]
                                        : tvList[1]
                                            [movieIndex - movieList[1].length],
                                    rating: 0.0,
                                    isPeople: true,
                                  ),
                                );
                              }),
                            ),
                          )
                    : _selectCategory == 1
                        ? movieList[0].isEmpty
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: ShowErrorMessage(
                                    errorMessage: "Your Movie List is Empty",
                                    extraInfo:
                                        "It seems that you haven't added any Movies to the list.",
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  top: 16,
                                  right: 8,
                                  bottom: 8,
                                ),
                                child: Wrap(
                                  children: List.generate(movieList[0].length,
                                      (int movieIndex) {
                                    return GestureDetector(
                                      onTap: () {
                                        GoRouter.of(context).pushNamed(
                                          MyAppRouteConstants.movieDetailsPage,
                                          extra: int.parse(
                                              movieList[0][movieIndex]),
                                        );
                                      },
                                      child: MovieCarouselModel(
                                        width: mySize.width / 2.25,
                                        height: mySize.height / 3.2,
                                        image: movieList[1][movieIndex],
                                        rating: 0.0,
                                        isPeople: true,
                                      ),
                                    );
                                  }),
                                ),
                              )
                        : tvList[0].isEmpty
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: ShowErrorMessage(
                                    errorMessage: "Your Tv Show List is Empty",
                                    extraInfo:
                                        "It seems that you haven't added any Tv Shows to the list.",
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  top: 16,
                                  right: 8,
                                  bottom: 8,
                                ),
                                child: Wrap(
                                  children: List.generate(tvList[0].length,
                                      (int tvIndex) {
                                    return GestureDetector(
                                      onTap: () {
                                        GoRouter.of(context).pushNamed(
                                          MyAppRouteConstants.tvShowDetailsPage,
                                          extra: tvList[0][tvIndex],
                                        );
                                      },
                                      child: MovieCarouselModel(
                                        width: mySize.width / 2.25,
                                        height: mySize.height / 3.2,
                                        image: tvList[1][tvIndex],
                                        rating: 0.0,
                                        isPeople: true,
                                      ),
                                    );
                                  }),
                                ),
                              ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
