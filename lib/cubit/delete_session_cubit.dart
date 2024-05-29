import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix/repo/auth/delete_session_repo.dart';

import '../models/For APIs/auth/delete_session_model.dart';

part 'delete_session_state.dart';

class DeleteSessionCubit extends Cubit<DeleteSessionState> {
  DeleteSessionCubit(
    this.deleteSessionRepo,
  ) : super(DeleteSessionInitial());
  final DeleteSessionRepo deleteSessionRepo;

  void onDeletingSession(
    String sessionId,
  ) async {
    emit(DeleteSessionLoadingState());
    try {
      final deleteSessionModel = await deleteSessionRepo.deleteSession(
        sessionId,
      );
      emit(
        DeleteSessionLoadedState(
          deleteSessionModel: deleteSessionModel,
        ),
      );
    } catch (e) {
      emit(
        DeleteSessionErrorState(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
