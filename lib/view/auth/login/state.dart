part of 'bloc.dart';
class LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailedState extends LoginState {
  LoginFailedState();
}
