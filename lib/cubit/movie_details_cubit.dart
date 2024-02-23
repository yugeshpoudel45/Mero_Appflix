import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix/repo/movie_details_repo.dart';

import '../models/For APIs/movie_details_model.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit(this.moviesDetailsRepo) : super(MovieDetailsInitial());

  final MoviesDetailsRepo moviesDetailsRepo;

  void onFetchingMovieDetails(int movieId) async {
    emit(MovieDetailsLoadingState());
    try {
      final movieDetailsModel =
          await moviesDetailsRepo.fetchMovieDetails(movieId);
      emit(
        MovieDetailsLoadedState(
          movieDetailsModel: movieDetailsModel,
        ),
      );
    } catch (e) {
      emit(MovieDetailsErrorState(errorMessage: e.toString()));
    }
  }
}
