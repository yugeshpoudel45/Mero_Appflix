part of 'trending_section_cubit.dart';

sealed class TrendingSectionState extends Equatable {
  const TrendingSectionState();

  @override
  List<Object> get props => [];
}

final class TrendingSectionInitial extends TrendingSectionState {}

final class TrendingSectionLoadingState extends TrendingSectionState {}

final class TrendingSectionLoadedState extends TrendingSectionState {
  final TrendingMovieModel trendingMovieModel;
  final TrendingPeopleModel trendingPeopleModel;
  final TrendingTvShowModel trendingTvShowModel;
 
  const TrendingSectionLoadedState({
    required this.trendingPeopleModel, 
    required this.trendingTvShowModel,
    required this.trendingMovieModel,
  });

  @override
  List<Object> get props => [
        trendingMovieModel,
        trendingPeopleModel,
        trendingTvShowModel,
      ];
}

final class TrendingSectionErrorState extends TrendingSectionState {
  final String errorMessage;

  const TrendingSectionErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
