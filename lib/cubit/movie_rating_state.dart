part of 'movie_rating_cubit.dart';

sealed class MovieRatingState extends Equatable {
  const MovieRatingState();

  @override
  List<Object> get props => [];
}

final class MovieRatingInitial extends MovieRatingState {}

final class MovieRatingLoadingState extends MovieRatingState {}

final class MovieRatingLoadedState extends MovieRatingState {
  final MovieRatingModel movieratingmodel;

  const MovieRatingLoadedState({ 
    required this.movieratingmodel, 
  }); 

  @override
  List<Object> get props => [movieratingmodel];
}

final class MovieRatingErrorState extends MovieRatingState {
  final String errorMessage;

  const MovieRatingErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}