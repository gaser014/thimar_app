part of 'bloc.dart';

class ProductsState{}
class ProductsLoadingState extends ProductsState{}
class ProductsSuccessState extends ProductsState{
  final List<ProductModel> model;
  ProductsSuccessState({required this.model});
}

class ProductsFieldState extends ProductsState{
  final String message;
  ProductsFieldState({required this.message});
}