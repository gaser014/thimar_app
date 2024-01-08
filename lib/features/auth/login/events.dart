part of 'bloc.dart';

class LoginEvents {}

class LoginEvent extends LoginEvents {
  late final Map<String, dynamic>? data;
  late final String phone, password;
  LoginEvent({
    required this.phone,
    required this.password,
  }) {
    data = {
      "password": password,
      "phone": phone,
      "type": Platform.operatingSystem,
      "device_token": "test",
      "user_type": "client",
    };
  }
}
