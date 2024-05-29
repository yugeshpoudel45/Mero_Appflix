import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/buttons/other_buttons/bottom_sheet_buttons.dart';
import '../../cubit/movie_rating_cubit.dart';

class RatingModal extends StatefulWidget {
  const RatingModal({
    super.key,
    required this.movieId,
    this.isMovie = true,
  });
  final int movieId;
  final bool isMovie;

  @override
  State<RatingModal> createState() => _RatingModalState();
}

class _RatingModalState extends State<RatingModal> {
  bool ratingGiven = false;
  bool ratingDeleted = false;
  String movieRating = "1.0";

  @override
  void initState() {
    ratingDeleted = false;
    ratingGiven = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    Size mySize = MediaQuery.sizeOf(context);
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return Container(
      height: mySize.height / 2.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.horizontal_rule_rounded,
            size: 56,
            color: Colors.grey.shade400,
          ),
          Text(
            "Give Rating",
            style: myTextTheme.headlineSmall,
          ),
          const Divider(),
          SizedBox(
            height: mySize.height / 64,
          ),
          RatingBar(
            minRating: 0.5,
            initialRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            ratingWidget: RatingWidget(
              full: Icon(
                CupertinoIcons.star_fill,
                color: myColorScheme.onTertiary,
              ),
              half: Icon(
                CupertinoIcons.star_lefthalf_fill,
                color: myColorScheme.onTertiary,
              ),
              empty: Icon(
                CupertinoIcons.star,
                color: myColorScheme.onTertiary,
              ),
            ),
            updateOnDrag: true,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            onRatingUpdate: (rating) {
              setState(() {
                movieRating = (rating * 2).toString();
              });
            },
          ),
          BottomSheetButtons(
            buttonText1: "Cancel",
            buttonText2: "Submit",
            func1: () {
              setState(() {
                ratingDeleted = true;
                ratingGiven = false;
              });
              log("Rating Deleted");
              Fluttertoast.showToast(
                msg: 'Rating Deleted!',
                backgroundColor: Colors.red,
              );
              Navigator.of(context).pop();
            },
            func2: () {
              setState(() {
                ratingGiven = true;
                ratingDeleted = false;
              });
              Fluttertoast.showToast(
                msg: 'Rating Submitted!',
                backgroundColor: Colors.green,
              );
              log("Rating Submitted");
              Navigator.of(context).pop();
            },
          ),
          ratingGiven
              ? RatingGiven(
                  movieId: widget.movieId,
                  addRating: true,
                  rating: movieRating,
                  isMovie: widget.isMovie,
                )
              : const SizedBox(),
          ratingDeleted
              ? RatingGiven(
                  movieId: widget.movieId,
                  addRating: false,
                  isMovie: widget.isMovie,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
} 

class RatingGiven extends StatefulWidget {
  const RatingGiven({
    super.key,
    required this.movieId,
    required this.addRating,
    this.rating = "1.0",
    this.isMovie = true,
  });
  final int movieId;
  final String rating;
  final bool addRating;
  final bool isMovie;

  @override
  State<RatingGiven> createState() => _RatingGivenState();
}

class _RatingGivenState extends State<RatingGiven> {
  String sessionId = "";
  bool isGuest = true;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () async {
      await getSharedPref();
    });
    widget.isMovie
        ? isGuest
            ? widget.addRating
                ? context.read<MovieRatingCubit>().onGivingMovieRatingWithGuest(
                      widget.movieId,
                      widget.rating,
                      sessionId,
                    )
                : context
                    .read<MovieRatingCubit>()
                    .onDeletingMovieRatingWithGuest(
                      widget.movieId,
                      sessionId,
                    )
            : widget.addRating
                ? context.read<MovieRatingCubit>().onGivingMovieRatingWithUser(
                      widget.movieId,
                      widget.rating,
                      sessionId,
                    )
                : context
                    .read<MovieRatingCubit>()
                    .onDeletingMovieRatingWithUser(
                      widget.movieId,
                      sessionId,
                    )
        : isGuest
            ? widget.addRating
                ? context.read<MovieRatingCubit>().onGivingTvRatingWithGuest(
                      widget.movieId,
                      widget.rating,
                      sessionId,
                    )
                : context.read<MovieRatingCubit>().onDeletingTvRatingWithGuest(
                      widget.movieId,
                      sessionId,
                    )
            : widget.addRating
                ? context.read<MovieRatingCubit>().onGivingTvRatingWithUser(
                      widget.movieId,
                      widget.rating,
                      sessionId,
                    )
                : context.read<MovieRatingCubit>().onDeletingTvRatingWithUser(
                      widget.movieId,
                      sessionId,
                    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieRatingCubit, MovieRatingState>(
      builder: (context, state) {
        if (state is MovieRatingLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieRatingLoadedState) {
          return Column(
            children: [
              Text(state.movieratingmodel.statusCode.toString()),
              Text(state.movieratingmodel.statusMessage.toString()),
            ],
          );
        } else if (state is MovieRatingErrorState) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Future<void> getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sessionId = prefs.getString('sessionId') ?? "";
    isGuest = prefs.getBool('isGuest') ?? true;
  }
}
