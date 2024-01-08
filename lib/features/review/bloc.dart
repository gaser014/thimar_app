import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/logic/dio_helper.dart';

part 'model.dart';
part 'events.dart';

part 'states.dart';

class ReviewsBloc extends Bloc<ReviewEvents, ReviewStates> {
  ReviewsBloc() : super(ReviewStates()) {
    on<ReviewEvent>(_getProducts);
  }

  Future<void> _getProducts(ReviewEvent event, Emitter emit) async {
    emit(ReviewLoadingState());

    final response =
        await DioHelper().getData(endPoint: 'products/${event.id}/rates');
    if (response.isSuccess) {
      final model = ReviewData.fromJson(response.response!.data);
      emit(ReviewSuccessState(model: model.list));
    } else {
      emit(ReviewFieldState(message: response.message.toString()));
    }
  }
}
