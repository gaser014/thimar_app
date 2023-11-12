part of'bloc.dart';
class CardEvents{}
class GetCardEvent extends CardEvents{}
class SendCouponEvent extends CardEvents{}
class DeleteCardEvent extends CardEvents{
   CardData model;
  final int index;
  DeleteCardEvent({required this. model,required this.index});
}
class UpDateCardEvent extends CardEvents{
  final CardData model;
  final int index;
  final bool isAdd;
  UpDateCardEvent({required this.model,required this.index,required this.isAdd});
}