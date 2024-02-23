part of 'movie_details_cubit.dart';

sealed class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object> get props => [];
}

final class MovieDetailsInitial extends MovieDetailsState {}

final class MovieDetailsLoadingState extends MovieDetailsState {}

final class MovieDetailsLoadedState extends MovieDetailsState {
  final MovieDetailsModel movieDetailsModel;

  const MovieDetailsLoadedState({
    required this.movieDetailsModel,
  });

  @override
  List<Object> get props => [movieDetailsModel];
}

final class MovieDetailsErrorState extends MovieDetailsState {
  final String errorMessage;

  const MovieDetailsErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
