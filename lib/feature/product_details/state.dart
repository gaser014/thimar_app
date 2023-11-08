part of 'bloc.dart';

class FavState{

}
class FavLoadingState extends FavState{}
class FavSuccessState extends FavState{
  FavSuccessState(){

  }

}

class FavFieldState extends FavState{
  final String message;
  FavFieldState({required this.message});
}