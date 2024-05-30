import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/cubit/network_cubit.dart';
import 'package:netflix/cubit/network_state.dart';

import '../../models/others/movie_reviews_model.dart';

class ReviewsScreen extends StatelessWidget {
  final dynamic loadedState;
  final bool isMovie;
  const ReviewsScreen({
    super.key,
    required this.loadedState,
    this.isMovie = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isMovie
            ? Text(
                "${loadedState.movieDetailsModel.reviews!.results!.length} Reviews")
            : Text(
                "${loadedState.tvShowDetailsModel.reviews!.results!.length} Reviews"),
      ),
      body: isMovie
          ? loadedState.movieDetailsModel.reviews!.results!.isEmpty
              ? const Center(
                  child: Text("No Reviews given yet!"),
                )
              : BlocListener<NetworkCubit, NetworkState>(
                  listener: (context, state) {
                    if (state == NetworkState.disconnected) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'PLEASE CONNECT TO THE INTERNET',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          backgroundColor: Colors.red[400],
                          duration: const Duration(days: 1),
                          behavior: SnackBarBehavior.fixed,
                          dismissDirection: DismissDirection.none,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    }
                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: Column(
                        children: List.generate(
                            loadedState.movieDetailsModel.reviews!.results!
                                .length, (index) {
                          final movieReviews =
                              loadedState.movieDetailsModel.reviews!;
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
                    ),
                  ),
                )
          : loadedState.tvShowDetailsModel.reviews!.results!.isEmpty
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
                          loadedState.tvShowDetailsModel.reviews!.results!
                              .length, (index) {
                        final movieReviews =
                            loadedState.tvShowDetailsModel.reviews!;
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
                  ),
                ),
    );
  }
}
