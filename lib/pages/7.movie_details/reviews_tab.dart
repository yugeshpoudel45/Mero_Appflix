import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:netflix/components/Error/error_page.dart';
import 'package:netflix/config/app_constants.dart';

import '../../models/others/movie_reviews_model.dart';
import '../../models/others/readmore_model.dart';
import '../../routes/app_route_constant.dart';

class ReviewsTab extends StatefulWidget {
  final dynamic state;
  final bool isMovie;

  const ReviewsTab({
    super.key,
    required this.state,
    this.isMovie = true,
  });

  @override
  State<ReviewsTab> createState() => _ReviewsTabState();
}

class _ReviewsTabState extends State<ReviewsTab> {
  final GenerativeModel model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: GeminiConstants.apiKey,
  );

  Future<String> _sendInitialPrompt(String movie, String releaseYear) async {
    ChatSession session;
    session = model.startChat();

    try {
      final response = await session.sendMessage(
        Content.text(
            "You are a chatbot specialized in providing information about movies and TV shows.  The name and release year of a movie or TV show is $movie, $releaseYear. Your task is to identify whether it is a movie or TV show and provide AI generated rating and a short AI generated review. If you cannot find the information, politely inform the user."),
      );
      return response.text!.replaceAll('**', '');
    } catch (e) {
      return "Error in generating AI Review";
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 16,
          right: 16,
        ),
        child: widget.isMovie
            ? Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      CupertinoIcons.ant_circle_fill,
                    ),
                    title: Text(
                      "AI-Generated Review",
                      style: myTextTheme.titleLarge!.copyWith(
                        fontFamily: GoogleFonts.balsamiqSans().fontFamily!,
                      ),
                    ),
                  ),
                  FutureBuilder(
                      future: _sendInitialPrompt(
                        widget.state.movieDetailsModel.title!,
                        widget.state.movieDetailsModel.releaseDate!.year
                            .toString(),
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return const ShowErrorMessage(
                              errorMessage: "Error in AI Review",
                              extraInfo: "😓");
                        } else {
                          return Container(
                            decoration: BoxDecoration(
                              color: myColorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ReadMoreModel(
                                trimLines: 4,
                                text: snapshot.data.toString(),
                                textStyle: myTextTheme.bodyMedium!,
                              ),
                            ),
                          );
                        }
                      }),
                  SizedBox(
                    height: mySize.height / 64,
                  ),
                  const Divider(),
                  widget.state.movieDetailsModel.reviews!.results!.isEmpty
                      ? const SizedBox()
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Top Reviews",
                                  style: myTextTheme.titleLarge!.copyWith(
                                    fontFamily:
                                        GoogleFonts.balsamiqSans().fontFamily!,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    GoRouter.of(context).pushNamed(
                                      MyAppRouteConstants.reviewsPage,
                                      extra: widget.state,
                                      pathParameters: {
                                        "isMovie": "true",
                                      },
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
                              children: List.generate(
                                  widget.state.movieDetailsModel.reviews!
                                              .results!.length >
                                          1
                                      ? 1
                                      : widget.state.movieDetailsModel.reviews!
                                          .results!.length, (index) {
                                final movieReviews =
                                    widget.state.movieDetailsModel.reviews!;
                                return MovieReviewsModel(
                                  avatar: movieReviews.results![index]
                                      .authorDetails!.avatarPath!,
                                  name: movieReviews.results![index].author!,
                                  userName: movieReviews
                                      .results![index].authorDetails!.username!,
                                  rating: movieReviews
                                      .results![index].authorDetails!.rating!,
                                  comment:
                                      movieReviews.results![index].content!,
                                  datetime:
                                      movieReviews.results![index].createdAt!,
                                );
                              }),
                            ),
                          ],
                        )
                ],
              )
            : Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      CupertinoIcons.ant_circle_fill,
                    ),
                    title: Text(
                      "AI-Generated Review",
                      style: myTextTheme.titleLarge!.copyWith(
                        fontFamily: GoogleFonts.balsamiqSans().fontFamily!,
                      ),
                    ),
                  ),
                  FutureBuilder(
                      future: _sendInitialPrompt(
                        widget.state.tvShowDetailsModel.name!,
                        widget.state.tvShowDetailsModel.firstAirDate!.year
                            .toString(),
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return const ShowErrorMessage(
                              errorMessage: "Error in AI Review",
                              extraInfo: "😓");
                        } else {
                          return Container(
                            decoration: BoxDecoration(
                              color: myColorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ReadMoreModel(
                                trimLines: 4,
                                text: snapshot.data.toString(),
                                textStyle: myTextTheme.bodyMedium!,
                              ),
                            ),
                          );
                        }
                      }),
                  SizedBox(
                    height: mySize.height / 64,
                  ),
                  const Divider(),
                  widget.state.tvShowDetailsModel.reviews!.results!.isEmpty
                      ? const SizedBox()
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Top Reviews",
                                  style: myTextTheme.titleLarge!.copyWith(
                                    fontFamily:
                                        GoogleFonts.balsamiqSans().fontFamily!,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    GoRouter.of(context).pushNamed(
                                      MyAppRouteConstants.reviewsPage,
                                      extra: widget.state,
                                      pathParameters: {
                                        "isMovie": "false",
                                      },
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
                              children: List.generate(
                                  widget.state.tvShowDetailsModel.reviews!
                                              .results!.length >
                                          1
                                      ? 1
                                      : widget.state.tvShowDetailsModel.reviews!
                                          .results!.length, (index) {
                                final movieReviews =
                                    widget.state.tvShowDetailsModel.reviews!;
                                return MovieReviewsModel(
                                  avatar: movieReviews.results![index]
                                      .authorDetails!.avatarPath!,
                                  name: movieReviews.results![index].author!,
                                  userName: movieReviews
                                      .results![index].authorDetails!.username!,
                                  rating: movieReviews
                                      .results![index].authorDetails!.rating!,
                                  comment:
                                      movieReviews.results![index].content!,
                                  datetime:
                                      movieReviews.results![index].createdAt!,
                                );
                              }),
                            ),
                          ],
                        )
                ],
              ),
      ),
    );
  }
}
