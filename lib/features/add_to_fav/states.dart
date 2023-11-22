part of 'bloc.dart';

class FavStates {}

class FavInitialState extends FavStates {}

class FavLoadingState extends FavStates {}

class FavSuccessState extends FavStates {
  final ProductModel product;
  final String message;

  FavSuccessState({
    required this.product,
    required this.message,
  }) {
    showMessage(message: message, type: MassageType.success);
  }
}

class FavFieldState extends FavStates {
  final String message;

  FavFieldState({required this.message});
}
