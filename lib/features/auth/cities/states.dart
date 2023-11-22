part of 'bloc.dart';

class CitiesStates {}

class CitiesLoadingState extends CitiesStates {}

class CitiesSuccessState extends CitiesStates {
  final CitiesData model;
  CitiesSuccessState({required this.model});
}

class CitiesFailedState extends CitiesStates {
  String message;
  CitiesFailedState({required this.message});
}
