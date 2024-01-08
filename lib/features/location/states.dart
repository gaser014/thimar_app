part of 'bloc.dart';

class LocationState {}

class CurrentLocationLoadingState extends LocationState {}

class CurrentLocationSuccessState extends LocationState {
  Position position;

  CurrentLocationSuccessState({required this.position});
}

class CurrentLocationFieldsState extends LocationState {
  String massage;

  CurrentLocationFieldsState({required this.massage});
}

class AddressLoadingState extends LocationState {}

class AddressSuccessState extends LocationState {
  List<LocationModel> model;

  AddressSuccessState({required this.model});
}



class AddressFieldsState extends LocationState {
  String massage;

  AddressFieldsState({required this.massage});
}

class AddressDeleteSuccessState extends LocationState {}

class AddressUpdateSuccessState extends LocationState {}
