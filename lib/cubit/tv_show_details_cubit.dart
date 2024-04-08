import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/For APIs/tv_show_details_model.dart';
import '../repo/tv_show_details_repo.dart';

part 'tv_show_details_state.dart';

class TvShowDetailsCubit extends Cubit<TvShowDetailsState> {
  TvShowDetailsCubit(this.tvShowDetailsRepo) : super(TvShowDetailsInitial());

  final TvShowDetailsRepo tvShowDetailsRepo;

  void onFetchingTvShowDetails(int tvShowId) async {
    emit(TvShowDetailsLoadingState());
    try {
      final tvShowDetailsModel =
          await tvShowDetailsRepo.fetchTvShowDetails(tvShowId);
      emit(
        TvShowDetailsLoadedState(
          tvShowDetailsModel: tvShowDetailsModel,
        ),
      );
    } catch (e) {
      emit(TvShowDetailsErrorState(errorMessage: e.toString()));
    }
  }
}
