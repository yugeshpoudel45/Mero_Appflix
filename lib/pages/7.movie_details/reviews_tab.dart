import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/others/movie_reviews_model.dart';
import '../../routes/app_route_constant.dart';

class ReviewsTab extends StatelessWidget {
  final dynamic state;
  final bool isMovie;

  const ReviewsTab({
    super.key,
    required this.state,
    this.isMovie = true,
  });

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
        child: isMovie
            ? state.movieDetailsModel.reviews!.results!.isEmpty
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
                              fontFamily:
                                  GoogleFonts.balsamiqSans().fontFamily!,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context).pushNamed(
                                MyAppRouteConstants.reviewsPage,
                                extra: state,
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
                        children: List.generate(1, (index) {
                          final movieReviews = state.movieDetailsModel.reviews!;
                          return MovieReviewsModel(
                            avatar: movieReviews
                                .results![index].authorDetails!.avatarPath!,
                            name: movieReviews.results![index].author!,
                            userName: movieReviews
                                .results![index].authorDetails!.username!,
                            rating: movieReviews
                                .results![index].authorDetails!.rating!,
                            comment: movieReviews.results![index].content!,
                            datetime: movieReviews.results![index].createdAt!,
                          );
                        }),
                      ),
                    ],
                  )
            : state.tvShowDetailsModel.reviews!.results!.isEmpty
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
                              fontFamily:
                                  GoogleFonts.balsamiqSans().fontFamily!,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context).pushNamed(
                                MyAppRouteConstants.reviewsPage,
                                extra: state,
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
                        children: List.generate(1, (index) {
                          final movieReviews =
                              state.tvShowDetailsModel.reviews!;
                          return MovieReviewsModel(
                            avatar: movieReviews
                                .results![index].authorDetails!.avatarPath!,
                            name: movieReviews.results![index].author!,
                            userName: movieReviews
                                .results![index].authorDetails!.username!,
                            rating: movieReviews
                                .results![index].authorDetails!.rating!,
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
