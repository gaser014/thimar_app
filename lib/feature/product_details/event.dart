part of 'bloc.dart';

 class AddToCardEvents {}
class AddToCardEvent extends AddToCardEvents{
  final ProductModel model;
  AddToCardEvent({required this.model});
}

