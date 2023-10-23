part of 'bloc.dart';
class ConfirmState {}
class TimerState extends ConfirmState {
  int currentSecond = 90;
  TimerState(
    this.currentSecond,
      );
}
class TimerEnd extends ConfirmState {}
class ConfirmLoadingState extends ConfirmState {}

class ConfirmSuccessState extends ConfirmState {}

class ConfirmFailedState extends ConfirmState {
  ConfirmFailedState();
}
