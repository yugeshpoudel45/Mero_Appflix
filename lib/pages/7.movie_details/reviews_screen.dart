import 'package:flutter/material.dart';
import 'package:netflix/cubit/movie_details_cubit.dart';

import '../../models/others/movie_reviews_model.dart';

class ReviewsScreen extends StatelessWidget {
  final MovieDetailsLoadedState loadedState;
  const ReviewsScreen({super.key, required this.loadedState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${loadedState.movieDetailsModel.reviews!.results!.length} Reviews"),
      ),
      body: loadedState.movieDetailsModel.reviews!.results!.isEmpty
          ? const Center(
              child: Text("No Reviews given yet!"),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  children: List.generate(
                      loadedState.movieDetailsModel.reviews!.results!.length,
                      (index) {
                    final movieReviews = loadedState.movieDetailsModel.reviews!;
                    return MovieReviewsModel(
                      avatar: movieReviews
                          .results![index].authorDetails!.avatarPath!,
                      name: movieReviews.results![index].author!,
                      userName:
                          movieReviews.results![index].authorDetails!.username!,
                      rating:
                          movieReviews.results![index].authorDetails!.rating!,
                      comment: movieReviews.results![index].content!,
                      datetime: movieReviews.results![index].createdAt!,
                    );
                  }),
                ),
              ),
            ),
    );
  }
}
