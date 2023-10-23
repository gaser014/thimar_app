part of 'bloc.dart';
class ConfirmEvent {}
class VerifyEvent extends ConfirmEvent {
  String phone;
  VerifyEvent(this.phone);
}

class ResendEvent extends ConfirmEvent {
  String phone;
  ResendEvent(this.phone);
}
class ResetEvent extends ConfirmEvent {
  String phone;
  ResetEvent(this.phone);
}
class TimerEvent extends ConfirmEvent {}