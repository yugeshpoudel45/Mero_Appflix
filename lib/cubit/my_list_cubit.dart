import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_list_state.dart';

//!---------------------Improve this later--------------------
class MyListCubit extends Cubit<MyListState> {
  MyListCubit() : super(const MyListInitialState([], []));

  void addToMovieList(List<String> movieList) {
    final List<String> movieId = state.movieId;
    final List<String> movieImage = state.movieImage;
    movieId.add(movieList[0]);
    movieImage.add(movieList[1]);
    emit(MyListLoadedState(movieId, movieImage));
  }

  void getMovieList(List<List<String>> movieList) {
    final List<String> movieId = movieList[0];
    final List<String> movieImage = movieList[1];
    emit(MyListLoadedState(movieId, movieImage));
  }

  void clearMovieList() {
    emit(const MyListInitialState([], []));
  }

  void removeFromMovieList(String id) {
    final List<String> movieId = state.movieId;
    final List<String> movieImage = state.movieImage;
    movieImage.removeAt(movieId.indexOf(id));
    movieId.remove(id);
    emit(MyListLoadedState(movieId, movieImage));
  }

  void addToTvShowList(List<String> tvShowList) {
    final List<String> tvShowId = state.movieId;
    final List<String> tvShowImage = state.movieImage;
    tvShowId.add(tvShowList[0]);
    tvShowImage.add(tvShowList[1]);
    emit(MyListLoadedState(tvShowId, tvShowImage));
  }

  void getTvShowList(List<List<String>> tvShowList) {
    final List<String> tvShowId = tvShowList[0];
    final List<String> tvShowImage = tvShowList[1];
    emit(MyListLoadedState(tvShowId, tvShowImage));
  }

  void clearTvShowList() {
    emit(const MyListInitialState([], []));
  }

  void removeFromTvShowList(String id) {
    final List<String> tvShowId = state.movieId;
    final List<String> tvShowImage = state.movieImage;
    tvShowImage.removeAt(tvShowId.indexOf(id));
    tvShowId.remove(id);
    emit(MyListLoadedState(tvShowId, tvShowImage));
  }

  void clearAllList() {
    emit(const MyListInitialState([], []));
  }
}
