part of 'bloc.dart';

 class FavState{

 }
class FavInitialState extends FavState{

      }
class FavLoadingState extends FavState{
}
class FavSuccessState extends FavState{
  final ProductModel product;
FavSuccessState(this.product);
    }



class FavFieldState extends FavState{
  final String message;
  FavFieldState({required this.message});
}