part of 'bloc.dart';

class AddToCardEvents {}

class AddToCardEvent extends AddToCardEvents {
  final ProductModel model;
  final bool isNavigateToDetails;
  final void Function()? function;

  AddToCardEvent({
    required this.model,
    this.isNavigateToDetails = false,
    this.function,
  });
}
