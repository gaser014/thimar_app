part of'bloc.dart';

class CardState{}
class CardLoadingState extends CardState{}
class CardSuccessState extends CardState{
  final CardData model;
  CardSuccessState({required this.model});
}
class CardFieldState extends CardState{
  final String message;
  CardFieldState({required this.message});
}