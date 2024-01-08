part of 'bloc.dart';

class ResetPasswordEvents {}

class ResetPasswordEvent extends ResetPasswordEvents {
  final String phone;
  final String code;
  final String password;
  late final Map<String, dynamic> date;
  ResetPasswordEvent({
    required this.phone,
    required this.code,
    required this.password,
  }) {
    date = {
      "code": code,
      "phone": phone,
      "password": password,
    };
  }
}
