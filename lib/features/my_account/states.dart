part of 'bloc.dart';

class MyAccountStates {}

class MyAccountLoadingState extends MyAccountStates {}

class MyAccountSuccessState extends MyAccountStates {
  final UserModel model;
  MyAccountSuccessState({required this.model});
}

class MyAccountFieldState extends MyAccountStates {
  final String message;
  MyAccountFieldState({required this.message}) {
    showMessage(message: message);
  }
}
