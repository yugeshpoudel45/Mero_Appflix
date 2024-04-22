import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix/models/For%20APIs/movie_search_model.dart';
import 'package:netflix/models/For%20APIs/people_search_model.dart';
import 'package:netflix/models/For%20APIs/tvShow_search_model.dart';
import 'package:netflix/repo/search_page_repo.dart';

part 'search_section_state.dart';

class SearchSectionCubit extends Cubit<SearchSectionState> {
  SearchSectionCubit(this.searchRepo) : super(SearchSectionInitial());

  final SearchRepo searchRepo;

  void onFetchingSearchSection(
    String name,
    bool includeAdult,
    int releaseYear,
  ) async {
    emit(SearchSectionLoadingState());
    try {
      final movieSearchModel = await searchRepo.fetchSearchMovies(
        name,
        includeAdult,
        releaseYear,
      );
      final tvShowSearchModel = await searchRepo.fetchSearchTvShow(
        name,
        includeAdult,
        releaseYear,
      );
      final peopleSearchModel = await searchRepo.fetchSearchPeople(
        name,
        includeAdult,
      );
      emit(SearchSectionLoadedState(
        movieSearchModel: movieSearchModel,
        tvShowSearchModel: tvShowSearchModel,
        peopleSearchModel: peopleSearchModel,
      ));
    } catch (e) {
      emit(SearchSectionErrorState(errorMessage: e.toString()));
    }
  }
}
