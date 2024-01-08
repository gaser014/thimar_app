part of 'bloc.dart';

class ConfirmEvents {}

class VerifyEvent extends ConfirmEvents {
  final String phone;
  final String code;
  late final Map<String, dynamic>? data;

  VerifyEvent({required this.phone, required this.code}) {
    data = {
      "code": code,
      "phone": phone,
      "type": Platform.operatingSystem,
      "device_token": "test",
    };
  }
}

class ResendEvent extends ConfirmEvents {
  final String phone;
  final bool isCheck;
  ResendEvent({required this.phone, this.isCheck = false});
}

class ResetEvent extends ConfirmEvents {
  final String phone;
  final String code;
  late final Map<String, dynamic>? data;
  ResetEvent({required this.phone, required this.code}) {
    data = {
      "code": code,
      "phone": phone,
    };
  }
}

class TimerEvent extends ConfirmEvents {}
