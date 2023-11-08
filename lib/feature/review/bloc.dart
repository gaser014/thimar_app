
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_assets.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/image.dart';

import '../../core/logic/dio_helper.dart';

part 'model.dart';
part 'view.dart';
part 'event.dart';

part 'state.dart';
class ReviewsBloc extends Bloc<ReviewEvents, ReviewState> {

  ReviewsBloc() : super(ReviewState()) {
    on<ReviewEvent>(_getProducts);
  }

  Future<void> _getProducts(ReviewEvent event, Emitter emit) async {
    emit(ReviewLoadingState());

    final response = await DioHelper().getData(endPoint: 'products/${event.id}/rates');
    if (response.isSuccess) {
      final model = ReviewData.fromJson(response.response!.data);
      emit(ReviewSuccessState(model: model.list));
    } else {
      emit(ReviewFieldState(message: response.message.toString()));
    }
  }
}
