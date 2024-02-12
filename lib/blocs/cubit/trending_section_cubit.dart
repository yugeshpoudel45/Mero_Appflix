import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix/models/trending_movie_model.dart';
import 'package:netflix/models/trending_people_model.dart';
import 'package:netflix/models/trending_tv_show.dart';
import 'package:netflix/repo/trending_repo.dart';

part 'trending_section_state.dart';

class TrendingSectionCubit extends Cubit<TrendingSectionState> {
  TrendingSectionCubit(this.trendingRepo) : super(TrendingSectionInitial());

  final TrendingRepo trendingRepo;

  void onFetchingTrendingSection() async {
    emit(TrendingSectionLoadingState());
    try {
      final trendingMovieModel = await trendingRepo.fetchTrendingMovies();
      final trendingPeopleModel = await trendingRepo.fetchTrendingPeople();
      final trendingTvShowModel = await trendingRepo.fetchTrendingTvShows();
      emit(
        TrendingSectionLoadedState(
          trendingPeopleModel: trendingPeopleModel,
          trendingTvShowModel: trendingTvShowModel,
          trendingMovieModel: trendingMovieModel,
        ),
      );
    } catch (e) {
      emit(TrendingSectionErrorState(errorMessage: e.toString()));
    }
  }
}
