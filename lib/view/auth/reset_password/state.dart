part of 'bloc.dart';
class ResetPasswordState {}

class ResetPasswordLoadingState extends ResetPasswordState {}

class ResetPasswordSuccessState extends ResetPasswordState {}

class ResetPasswordFailedState extends ResetPasswordState {
  ResetPasswordFailedState();
}
