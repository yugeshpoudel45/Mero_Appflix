part of 'my_list_cubit.dart';

sealed class MyListState extends Equatable {
  final List<String> movieId;
  final List<String> movieImage;
  const MyListState(this.movieId, this.movieImage);

  @override
  List<Object> get props => [];
}

final class MyListInitialState extends MyListState {
  const MyListInitialState(super.movieId, super.movieImage);

  @override
  List<Object> get props => [];
}

final class MyListLoadedState extends MyListState {
  const MyListLoadedState(super.movieId, super.movieImage);

  @override
  List<Object> get props => [movieId, movieImage];
}
