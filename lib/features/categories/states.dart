part of 'bloc.dart';

class CategoriesStates{}
class CategoriesLoadingState extends CategoriesStates{}
class CategoriesSuccessState extends CategoriesStates{
  final List<CategoriesModel> model;
  CategoriesSuccessState({required this.model});
}

class CategoriesFieldState extends CategoriesStates{
  final String message;
  CategoriesFieldState({required this.message}){showMessage(message: message);}
}