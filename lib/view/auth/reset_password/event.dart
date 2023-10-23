part of 'bloc.dart';
class ResetPasswordEvents {}
class ResetPasswordEvent extends ResetPasswordEvents {
  String phone;
  String code;
  ResetPasswordEvent({required this.phone,required this.code});
}
