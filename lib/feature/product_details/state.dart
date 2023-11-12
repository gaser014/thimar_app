part of 'bloc.dart';

 class AddToCardState {}
class AddToCardLoadingState extends AddToCardState{}
class AddToCardSuccessState extends AddToCardState{

    }
class AddToCardFieldState extends AddToCardState{
  final String message;
  AddToCardFieldState({required this.message});
}


