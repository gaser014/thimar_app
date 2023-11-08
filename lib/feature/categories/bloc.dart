import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/feature/categories_details/view.dart';

import '../../core/design/widget/image.dart';
import '../../core/logic/dio_helper.dart';
part  'model.dart';
part 'event.dart';
part 'state.dart';
part 'view.dart';
class CategoriesBloc extends Bloc<CategoriesEvents, CategoriesState> {
  int index = 0;
  CategoriesBloc() : super(CategoriesState()) {
    on<CategoriesEvent>(_getCategories);
  }

  Future<void> _getCategories(CategoriesEvent event, Emitter emit) async {
    emit(CategoriesLoadingState());

    final response = await DioHelper().getData(endPoint: 'categories');
    if (response.isSuccess) {
      final model = CategoriesData.fromJson(response.response!.data);
      emit(CategoriesSuccessState(model: model.list));
    }
    else{
      emit(CategoriesFieldState(message: response.message.toString()));
    }
  }

}