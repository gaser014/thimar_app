part of 'bloc.dart';

class RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterFailedState extends RegisterState {
  RegisterFailedState();
}
