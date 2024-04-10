part of 'people_details_cubit.dart';

sealed class PeopleDetailsState extends Equatable {
  const PeopleDetailsState();

  @override
  List<Object> get props => [];
}

final class PeopleDetailsInitial extends PeopleDetailsState {}

final class PeopleDetailsLoadingState extends PeopleDetailsState {}

final class PeopleDetailsLoadedState extends PeopleDetailsState {
  final PeopleDetailsModel peopleDetailsModel;

  const PeopleDetailsLoadedState({
    required this.peopleDetailsModel,
  });

  @override
  List<Object> get props => [peopleDetailsModel];
}

final class PeopleDetailsErrorState extends PeopleDetailsState {
  final String errorMessage;

  const PeopleDetailsErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}