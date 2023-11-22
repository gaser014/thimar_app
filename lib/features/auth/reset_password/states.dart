part of 'bloc.dart';
class ResetPasswordState {}

class ResetPasswordLoadingState extends ResetPasswordState {}

class ResetPasswordSuccessState extends ResetPasswordState {
  final String message;

  ResetPasswordSuccessState({required this.message}) {
    showMessage(
      message: message,
      type: MassageType.success,
    );
  }
}

class ResetPasswordFailedState extends ResetPasswordState {
  final String message;
  ResetPasswordFailedState({required this.message}) {
    showMessage(
      message: message,
    );
  }
}
