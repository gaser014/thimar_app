part of'bloc.dart';

class CardState{}
class CardLoadingState extends CardState{}
class CardSuccessState extends CardState{
  final CardData model;
  CardSuccessState({required this.model});
}
class CardFieldState extends CardState{
  final String message;
  CardFieldState({required this.message});
}
class CouponLoadingState extends CardState{}
class CouponSuccessState extends CardState{
  final Coupon model;
  CouponSuccessState({required this.model});
}
class CouponFieldState extends CardState{
  final String message;
  CouponFieldState({required this.message});
}
class DeleteCardLoadingState extends CardState{}

class  DeleteCardFieldState extends CardState{
  final String message;
  DeleteCardFieldState({required this.message});
}class UpDateCardLoadingState extends CardState{}

class  UpDateCardFieldState extends CardState{
  final String message;
  UpDateCardFieldState({required this.message});
}