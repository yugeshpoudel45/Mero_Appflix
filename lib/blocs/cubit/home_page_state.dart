// part of 'home_page_cubit.dart';

// sealed class HomePageState extends Equatable {
//   const HomePageState();

//   @override
//   List<Object> get props => [];
// }

// final class HomePageInitial extends HomePageState {}

// final class HomePageLoadingState extends HomePageState {}

// final class HomePageLoadedState extends HomePageState {
//   final TrendingMovieModel trendingMovieModel;

//   const HomePageLoadedState({required this.trendingMovieModel});

//   @override
//   List<Object> get props => [trendingMovieModel];
// }

// final class HomePageErrorState extends HomePageState {
//   final String errorMessage;

//   const HomePageErrorState({required this.errorMessage});

//   @override
//   List<Object> get props => [errorMessage];
// }

//-------------------------------------------------------------------------------------------------------------------
part of 'home_page_cubit.dart';

sealed class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

final class HomePageInitial extends HomePageState {}

final class HomePageLoadingState extends HomePageState {}

final class HomePageLoadedState extends HomePageState {
  final TrendingMovieModel trendingMovieModel;
  // final TrendingPeopleModel trendingPeopleModel;
  // final TrendingTvShowModel trendingTvShowModel;

  const HomePageLoadedState({
    // required this.trendingPeopleModel,
    // required this.trendingTvShowModel, 
    required this.trendingMovieModel,
  });

  @override
  List<Object> get props => [
        trendingMovieModel,
        // trendingPeopleModel,
        // trendingTvShowModel,
      ];
}

final class HomePageErrorState extends HomePageState {
  final String errorMessage;

  const HomePageErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
