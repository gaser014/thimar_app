part of 'bloc.dart';

class RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final String message;
  final String phone;
  final bool isActivated;

  RegisterSuccessState({
    required   this.phone,
    required   this.isActivated,
    required this.message,
  }) {
    showMessage(
      message: message,
      type: MassageType.success,
    );
  }
}

class RegisterFailedState extends RegisterStates {
  final String message;

  RegisterFailedState({required this.message}) {
    showMessage(
      message: message,
    );
  }
}
