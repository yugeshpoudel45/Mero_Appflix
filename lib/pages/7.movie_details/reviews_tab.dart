import 'dart:developer';

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

  String aiReview = "";

  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    _sendInitialPrompt();
    isLoading = false;
    super.initState();
  }

  Future<void> _sendInitialPrompt() async {
    ChatSession session;
    session = model.startChat();
    final response = await session.sendMessage(
      Content.text(
        "${GeminiConstants.movieReviewPrompt} PK ",
      ),
    );
    setState(() {
      aiReview = response.text!;
    });
    // try {

    // } catch (e) {
    //   log(e.toString());
    //   if (context.mounted) {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(SnackBar(content: Text(e.toString())));
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 16,
                right: 16,
              ),
              child: widget.isMovie
                  ? widget.state.movieDetailsModel.reviews!.results!.isEmpty
                      ? const Center(
                          child: ShowErrorMessage(
                          errorMessage: "No Reviews given yet!",
                          extraInfo: "😓",
                        ))
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
                                          2
                                      ? 2
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
                  : widget.state.tvShowDetailsModel.reviews!.results!.isEmpty
                      ? const Center(
                          child: ShowErrorMessage(
                            errorMessage: "No Reviews given yet!",
                            extraInfo: "😣",
                          ),
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
                                  fontFamily:
                                      GoogleFonts.balsamiqSans().fontFamily!,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                bottom: 16,
                              ),
                              child: ReadMoreModel(
                                text: aiReview.isEmpty
                                    ? "No review found"
                                    // : aiReview.replaceAll('*', ''),
                                    : aiReview,
                                textStyle: myTextTheme.bodyMedium!,
                              ),
                            ),
                            const Divider(),
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
                        ),
            ),
          );
  }
}
