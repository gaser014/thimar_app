part of 'bloc.dart';

class ConfirmStates {}

class TimerStartedState extends ConfirmStates {
  final int currentSecond;
  TimerStartedState({this.currentSecond = 90});
}

class TimerEnd extends ConfirmStates {}

class ConfirmLoadingState extends ConfirmStates {}

class ConfirmSuccessState extends ConfirmStates {
  final String message, phone, code;
  ConfirmSuccessState({
    required this.message,
    required this.phone,
    required this.code,
  }) {
    showMessage(
      message: message,
      type: MassageType.success,
    );
  }
}

class VerifySuccessState extends ConfirmStates {
  final String message;
  VerifySuccessState({required this.message}) {
    showMessage(
      message: message,
      type: MassageType.success,
    );
  }
}

class ResendSuccessState extends ConfirmStates {
  final String message;
  ResendSuccessState({required this.message}) {
    showMessage(
      message: message,
      type: MassageType.success,
    );
  }
}

class ConfirmFailedState extends ConfirmStates {
  final String message;
  ConfirmFailedState({required this.message}) {
    showMessage(
      message: message,
    );
  }
}
