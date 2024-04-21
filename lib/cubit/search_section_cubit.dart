import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix/models/For%20APIs/movie_search_model.dart';

part 'search_section_state.dart';

class SearchSectionCubit extends Cubit<SearchSectionState> {
  SearchSectionCubit() : super(SearchSectionInitial());

  void onFetchingSearchSection() async {
    emit(SearchSectionLoadingState());
    try {
      // final movieSearchModel = await searchSectionRepo.fetchMovieSearch()
      // emit(
      //   SearchSectionLoadedState(movieSearchModel: movieSearchModel)
      // );
    } catch (e) {
      emit(SearchSectionErrorState(errorMessage: e.toString()));
    }
  }
}
