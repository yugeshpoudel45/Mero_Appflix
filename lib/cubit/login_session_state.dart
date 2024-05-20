part of 'login_session_cubit.dart';

sealed class LoginSessionState extends Equatable {
  const LoginSessionState();

  @override
  List<Object> get props => [];
}

final class LoginSessionInitial extends LoginSessionState {}

final class LoginSessionLoadingState extends LoginSessionState {}

final class LoginSessionLoadedState extends LoginSessionState {
  final LoginSessionModel loginSessionModel;

  const LoginSessionLoadedState({required this.loginSessionModel});

  @override
  List<Object> get props => [loginSessionModel];
}

final class LoginSessionErrorState extends LoginSessionState {
  final String errorMessage;

  const LoginSessionErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
