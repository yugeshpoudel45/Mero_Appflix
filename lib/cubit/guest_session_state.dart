part of 'guest_session_cubit.dart';

sealed class GuestSessionState extends Equatable {
  const GuestSessionState();

  @override
  List<Object> get props => [];
}

final class GuestSessionInitial extends GuestSessionState {}

final class GuestSessionLoadingState extends GuestSessionState {}

final class GuestSessionLoadedState extends GuestSessionState {
  final GuestSessionModel guestSessionModel;

  const GuestSessionLoadedState({required this.guestSessionModel});

  @override
  List<Object> get props => [guestSessionModel]; 
}

final class GuestSessionErrorState extends GuestSessionState {
  final String errorMessage;

  const GuestSessionErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
