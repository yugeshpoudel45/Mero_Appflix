import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix/models/trending_movie_model.dart';
import 'package:netflix/models/trending_people_model.dart';
import 'package:netflix/models/trending_tv_show.dart';
import 'package:netflix/repo/trending_repo.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this.trendingRepo) : super(HomePageInitial());

  final TrendingRepo trendingRepo;

  void onFetchingTrendingSection() async {
    emit(HomePageLoadingState());
    try {
      final trendingMovieModel = await trendingRepo.fetchTrendingMovies();
      // final trendingPeopleModel = await trendingRepo.fetchTrendingPeople();
      // final trendingTvShowModel = await trendingRepo.fetchTrendingTvShows();
      emit(
        HomePageLoadedState(
          // trendingPeopleModel: trendingPeopleModel,
          // trendingTvShowModel: trendingTvShowModel,
          trendingMovieModel: trendingMovieModel,
        ),
      );
    } catch (e) {
      emit(HomePageErrorState(errorMessage: e.toString()));
    }
  }
}
