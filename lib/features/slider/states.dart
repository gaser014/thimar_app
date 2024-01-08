part of 'bloc.dart';

class SliderStates {}

class SliderLoadingState extends SliderStates {}

class SliderSuccessState extends SliderStates {
  final List<SliderModel> model;
  SliderSuccessState({required this.model});
}

class SliderFieldState extends SliderStates {
  final String message;
  SliderFieldState({required this.message}) {
    showMessage(message: message);
  }
}
