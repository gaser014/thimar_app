part of 'bloc.dart';

class CardEvents {}

class GetCardEvent extends CardEvents {
  final String massage;
  GetCardEvent({required this.massage});
}

class SendCouponEvent extends CardEvents {
  final String couponController;
  SendCouponEvent({required this.couponController});
}

class DeleteCardEvent extends CardEvents {
  CardData model;
  final int index;
  DeleteCardEvent({required this.model, required this.index});
}

class UpDateCardEvent extends CardEvents {
  final CardData model;
  final int index;
  final int addAmount;
  UpDateCardEvent(
      {required this.model, required this.index, required this.addAmount});
}
