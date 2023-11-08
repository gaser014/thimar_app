part of 'bloc.dart';

class ReviewState{}
class ReviewLoadingState extends ReviewState{}
class ReviewSuccessState extends ReviewState{
  final List<ReviewModel> model;
  ReviewSuccessState({required this.model});
}

class ReviewFieldState extends ReviewState{
  final String message;
  ReviewFieldState({required this.message});
}