part of 'bloc.dart';

class CategoriesState{}
class CategoriesLoadingState extends CategoriesState{}
class CategoriesSuccessState extends CategoriesState{
  final List<CategoriesModel> model;
  CategoriesSuccessState({required this.model});
}

class CategoriesFieldState extends CategoriesState{
  final String message;
  CategoriesFieldState({required this.message});
}