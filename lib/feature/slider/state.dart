part of 'bloc.dart';

class SliderState{}
class SliderLoadingState extends SliderState{}
class SliderSuccessState extends SliderState{
  final List<SliderModel> model;
  SliderSuccessState({required this.model});
}

class SliderFieldState extends SliderState{
  final String message;
  SliderFieldState({required this.message});
}