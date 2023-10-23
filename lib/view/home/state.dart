part of 'bloc.dart';

class HomeState {}

class HomeBottomNavState extends HomeState {


  int index;
  Widget body;

  HomeBottomNavState({
    required this.body,

    required this.index,
  });
}
