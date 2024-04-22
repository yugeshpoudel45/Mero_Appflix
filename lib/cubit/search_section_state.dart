part of 'search_section_cubit.dart';

sealed class SearchSectionState extends Equatable {
  const SearchSectionState();

  @override
  List<Object> get props => [];
}

final class SearchSectionInitial extends SearchSectionState {}

final class SearchSectionLoadingState extends SearchSectionState {}

final class SearchSectionLoadedState extends SearchSectionState {
  final MovieSearchModel movieSearchModel;
  final TvShowSearchModel tvShowSearchModel;
  final PeopleSearchModel peopleSearchModel;

  const SearchSectionLoadedState({
    required this.tvShowSearchModel,
    required this.peopleSearchModel,
    required this.movieSearchModel,
  });

  @override
  List<Object> get props => [
        movieSearchModel,
        tvShowSearchModel,
        peopleSearchModel,
      ];
}

final class SearchSectionErrorState extends SearchSectionState {
  final String errorMessage;

  const SearchSectionErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
