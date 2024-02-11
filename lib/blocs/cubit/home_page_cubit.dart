import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix/models/trending_people_model.dart';
import 'package:netflix/repo/trending_repo.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this.trendingRepo) : super(HomePageInitial());

  final TrendingRepo trendingRepo;

  void onFetchingTrendingMovies() async {
    emit(HomePageLoadingState());
    try {
      final trendingMovieModel = await trendingRepo.fetchTrendingMovies();
      emit(HomePageLoadedState(trendingMovieModel: trendingMovieModel));
    } catch (e) {
      emit(HomePageErrorState(errorMessage: e.toString()));
    }
  }
}
