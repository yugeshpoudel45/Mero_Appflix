import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/For APIs/movie_rating_model.dart';
import '../repo/movie_rating_repo.dart';

part 'movie_rating_state.dart';

class MovieRatingCubit extends Cubit<MovieRatingState> {
  MovieRatingCubit(this.movieRatingRepo) : super(MovieRatingInitial());

  final MovieRatingRepo movieRatingRepo;

  void onGivingMovieRatingWithGuest(
    int movieId,
    String rating,
    String guestId,
  ) async {
    emit(MovieRatingLoadingState());
    try {
      final movieRatingModel = await movieRatingRepo.giveMovieRatingWithGuest(
          movieId, rating, guestId);
      emit(MovieRatingLoadedState(
        movieratingmodel: movieRatingModel,
      ));
    } catch (e) {
      emit(MovieRatingErrorState(errorMessage: e.toString()));
    }
  }

  void onGivingMovieRatingWithUser(
    int movieId,
    String rating,
    String userId,
  ) async {
    emit(MovieRatingLoadingState());
    try {
      final movieRatingmodel = await movieRatingRepo.giveMovieRatingWithUser(
          movieId, rating, userId);
      emit(MovieRatingLoadedState(
        movieratingmodel: movieRatingmodel,
      ));
    } catch (e) {
      emit(MovieRatingErrorState(errorMessage: e.toString()));
    }
  }

  void onDeletingMovieRatingWithGuest(
    int movieId,
    String userId,
  ) async {
    emit(MovieRatingLoadingState());
    try {
      final movieRatingmodel =
          await movieRatingRepo.deleteMovieRatingWithGuest(movieId, userId);
      emit(MovieRatingLoadedState(
        movieratingmodel: movieRatingmodel,
      ));
    } catch (e) {
      emit(MovieRatingErrorState(errorMessage: e.toString()));
    }
  }

  void onDeletingMovieRatingWithUser(
    int movieId,
    String userId,
  ) async {
    emit(MovieRatingLoadingState());
    try {
      final movieRatingmodel =
          await movieRatingRepo.deleteMovieRatingWithUser(movieId, userId);
      emit(MovieRatingLoadedState(
        movieratingmodel: movieRatingmodel,
      ));
    } catch (e) {
      emit(MovieRatingErrorState(errorMessage: e.toString()));
    }
  }

  //!------------------------FOR TV SHOWS------------------------
  void onGivingTvRatingWithGuest(
    int movieId,
    String rating,
    String guestId,
  ) async {
    emit(MovieRatingLoadingState());
    try {
      final movieRatingModel =
          await movieRatingRepo.giveTvRatingWithGuest(movieId, rating, guestId);
      emit(MovieRatingLoadedState(
        movieratingmodel: movieRatingModel,
      ));
    } catch (e) {
      emit(MovieRatingErrorState(errorMessage: e.toString()));
    }
  }

  void onGivingTvRatingWithUser(
    int movieId,
    String rating,
    String userId,
  ) async {
    emit(MovieRatingLoadingState());
    try {
      final movieRatingmodel =
          await movieRatingRepo.giveTvRatingWithUser(movieId, rating, userId);
      emit(MovieRatingLoadedState(
        movieratingmodel: movieRatingmodel,
      ));
    } catch (e) {
      emit(MovieRatingErrorState(errorMessage: e.toString()));
    }
  }

  void onDeletingTvRatingWithGuest(
    int movieId,
    String userId,
  ) async {
    emit(MovieRatingLoadingState());
    try {
      final movieRatingmodel =
          await movieRatingRepo.deleteTvRatingWithGuest(movieId, userId);
      emit(MovieRatingLoadedState(
        movieratingmodel: movieRatingmodel,
      ));
    } catch (e) {
      emit(MovieRatingErrorState(errorMessage: e.toString()));
    }
  }

  void onDeletingTvRatingWithUser(
    int movieId,
    String userId,
  ) async {
    emit(MovieRatingLoadingState());
    try {
      final movieRatingmodel =
          await movieRatingRepo.deleteTvRatingWithUser(movieId, userId);
      emit(MovieRatingLoadedState(
        movieratingmodel: movieRatingmodel,
      ));
    } catch (e) {
      emit(MovieRatingErrorState(errorMessage: e.toString()));
    }
  }
}
