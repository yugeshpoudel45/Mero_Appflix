import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix/models/For%20APIs/auth/guest_session_model.dart';
import 'package:netflix/repo/auth/guest_session_repo.dart';

part 'guest_session_state.dart';

class GuestSessionCubit extends Cubit<GuestSessionState> {
  GuestSessionCubit(this.guestSessionRepo) : super(GuestSessionInitial());

  final GuestSessionRepo guestSessionRepo;

  void onGeneratingGuestSession() async {
    emit(GuestSessionLoadingState());
    try {
      final guestSessionModel = await guestSessionRepo.generateGuestSession();
      emit(
        GuestSessionLoadedState(
          guestSessionModel: guestSessionModel,
        ),
      );
    } catch (e) {
      emit(GuestSessionErrorState(errorMessage: e.toString()));
    }
  }
}
