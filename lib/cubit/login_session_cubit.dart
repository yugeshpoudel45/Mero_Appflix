import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/For APIs/auth/login_session_model.dart';
import '../repo/auth/login_session_repo.dart';

part 'login_session_state.dart';

class LoginSessionCubit extends Cubit<LoginSessionState> {
  LoginSessionCubit(this.loginSessionRepo) : super(LoginSessionInitial());

  final LoginSessionRepo loginSessionRepo;

  void onGeneratingLoginSession({
    required String username,
    required String password,
  }) async {
    emit(LoginSessionLoadingState());
    try {
      final loginSessionModel = await loginSessionRepo.generateLoginSession(
        username,
        password,
      );
      emit(
        LoginSessionLoadedState(
          loginSessionModel: loginSessionModel,
        ),
      );
    } catch (e) {
      emit(LoginSessionErrorState(errorMessage: e.toString()));
    }
  }
}
