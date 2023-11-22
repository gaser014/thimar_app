
part of 'bloc.dart';
class ForgetPasswordStates {}

class ForgetPasswordLoadingState extends ForgetPasswordStates {}

class ForgetPasswordSuccessState extends ForgetPasswordStates {
 final String phone;
 final bool isActive;

  ForgetPasswordSuccessState({required this.phone, required this.isActive});
}

class ForgetPasswordFailedState extends ForgetPasswordStates {
  String error;
  ForgetPasswordFailedState({required this.error}){
   showMessage(message: error);  }
}