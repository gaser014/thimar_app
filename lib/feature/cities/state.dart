part of 'bloc.dart';

class CitiesState {}

class CitiesLoadingState extends CitiesState {}

class CitiesSuccessState extends CitiesState {
  final CitiesData model;
  CitiesSuccessState({required this.model});
}

class CitiesFailedState extends CitiesState {
  String message;
  CitiesFailedState(this.message);
}
