part of 'bloc.dart';

class ReviewStates {}

class ReviewLoadingState extends ReviewStates {}

class ReviewSuccessState extends ReviewStates {
  final List<ReviewModel> model;
  ReviewSuccessState({required this.model});
}

class ReviewFieldState extends ReviewStates {
  final String message;
  ReviewFieldState({required this.message});
}
