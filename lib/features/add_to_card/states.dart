part of 'bloc.dart';

 class AddToCardStates {}
class AddToCardLoadingState extends AddToCardStates{
   final int id;

   AddToCardLoadingState({ required this.id});
}
class AddToCardSuccessState extends AddToCardStates{
  final String message;
   bool isGetCard;
AddToCardSuccessState({ required this.message,this.isGetCard=false,}) {
  showMessage(message: message, type: MassageType.success);
}

}
class AddToCardFieldState extends AddToCardStates{
  final String message;
  AddToCardFieldState({required this.message}){
    showMessage(message: message);

  }
}


