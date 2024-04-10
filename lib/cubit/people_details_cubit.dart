import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/For APIs/people_details_model.dart';
import '../repo/people_details_repo.dart';

part 'people_details_state.dart';

class PeopleDetailsCubit extends Cubit<PeopleDetailsState> {
  PeopleDetailsCubit(this.peopleDetailsRepo) : super(PeopleDetailsInitial());

  final PeopleDetailsRepo peopleDetailsRepo;

  void onFetchingPeopleDetails(int peopleId) async {
    emit(PeopleDetailsLoadingState());
    try {
      final peopleDetailsModel =
          await peopleDetailsRepo.fetchPeopleDetails(peopleId);
      emit(
        PeopleDetailsLoadedState(
          peopleDetailsModel: peopleDetailsModel,
        ),
      );
    } catch (e) {
      emit(PeopleDetailsErrorState(errorMessage: e.toString()));
    }
  }
}
