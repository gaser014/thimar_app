import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/design/widget/image.dart';
import '../../core/logic/dio_helper.dart';
part  'model.dart';
part 'event.dart';
part 'state.dart';
part 'view.dart';
class SliderBloc extends Bloc<SliderEvents, SliderState> {
  int index = 0;
  SliderBloc() : super(SliderState()) {
    on<SliderEvent>(_getSlider);
  }

  Future<void> _getSlider(SliderEvent event, Emitter emit) async {
    emit(SliderLoadingState());

    final response = await DioHelper().getData(endPoint: 'sliders');
    if (response.isSuccess) {
      final model = SliderData.fromJson(response.response!.data);
      emit(SliderSuccessState(model: model.list));
    }
    else{
      emit(SliderFieldState(message: response.message.toString()));
    }
  }

}