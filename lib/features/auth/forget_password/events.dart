part of 'bloc.dart';

class ForgetPasswordEvents {}

class ForgetPasswordEvent extends ForgetPasswordEvents {
  final String phone;
  late final Map<String, dynamic>? data;
  ForgetPasswordEvent({required this.phone}) {
    data = {
      "phone": phone,
    };
  }
}
