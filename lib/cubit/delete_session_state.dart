part of 'delete_session_cubit.dart';

sealed class DeleteSessionState extends Equatable {
  const DeleteSessionState();

  @override
  List<Object> get props => [];
}

final class DeleteSessionInitial extends DeleteSessionState {}

final class DeleteSessionLoadingState extends DeleteSessionState {}

final class DeleteSessionLoadedState extends DeleteSessionState {
  final DeleteSessionModel deleteSessionModel;

  const DeleteSessionLoadedState({required this.deleteSessionModel});

  @override
  List<Object> get props => [deleteSessionModel];
}

final class DeleteSessionErrorState extends DeleteSessionState {
  final String errorMessage;

  const DeleteSessionErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
