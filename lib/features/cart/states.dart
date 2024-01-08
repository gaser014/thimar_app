part of 'bloc.dart';

class CardStates {}

class CardLoadingState extends CardStates {}

class CardSuccessState extends CardStates {
  final CardData model;
  CardSuccessState({required this.model});
}

class CardFieldState extends CardStates {
  final String message;
  CardFieldState({required this.message});
}

class CouponLoadingState extends CardStates {}

class CouponSuccessState extends CardStates {
  final Coupon model;

  CouponSuccessState({required this.model}) {
    showMessage(message: model.message, type: MassageType.success);
  }
}

class CouponFieldState extends CardStates {
  final String message;
  CouponFieldState({required this.message}) {
    showMessage(message: message);
  }
}

class DeleteCardLoadingState extends CardStates {}

class DeleteCardFieldState extends CardStates {
  final String message;
  DeleteCardFieldState({required this.message});
}

class UpDateCardLoadingState extends CardStates {}

class UpDateCardFieldState extends CardStates {
  final String message;
  UpDateCardFieldState({required this.message}) {
    showMessage(message: message);
  }
}
