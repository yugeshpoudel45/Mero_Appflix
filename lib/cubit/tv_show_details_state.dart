part of 'tv_show_details_cubit.dart';

sealed class TvShowDetailsState extends Equatable {
  const TvShowDetailsState();

  @override
  List<Object> get props => [];
}

final class TvShowDetailsInitial extends TvShowDetailsState {}


final class TvShowDetailsLoadingState extends TvShowDetailsState {}

final class TvShowDetailsLoadedState extends TvShowDetailsState {
  final TvShowDetailsModel tvShowDetailsModel;

  const TvShowDetailsLoadedState({
    required this.tvShowDetailsModel,
  });

  @override
  List<Object> get props => [tvShowDetailsModel];
}

final class TvShowDetailsErrorState extends TvShowDetailsState {
  final String errorMessage;

  const TvShowDetailsErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}