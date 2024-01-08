part of 'bloc.dart';

class ProductsStates {}

class ProductsLoadingState extends ProductsStates {}

class ProductsSuccessState extends ProductsStates {
  final List<ProductModel> model;
  ProductsSuccessState({required this.model});
}

class ProductsFieldState extends ProductsStates {
  final String message;
  ProductsFieldState({required this.message}) {
    showMessage(message: message);
  }
}
