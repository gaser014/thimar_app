import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_assets.dart';
import 'package:themar/core/design/widget/app_bar_icon.dart';
import 'package:themar/core/design/widget/app_grid.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/feature/product_details/view.dart';

import '../../core/design/unit/app_string.dart';
import '../../core/design/widget/image.dart';
import '../../core/logic/dio_helper.dart';

part 'model.dart';

part 'event.dart';

part 'state.dart';
part 'view.dart';
class ProductsBloc extends Bloc<ProductsEvents, ProductsState> {
  int index = 0;

  ProductsBloc() : super(ProductsState()) {
    on<ProductEvent>(_getProducts);
  }

  Future<void> _getProducts(ProductEvent event, Emitter emit) async {
    emit(ProductsLoadingState());
    final response = await DioHelper().getData(endPoint: endPoint(event.type,id: event.id),haveToken: true,
    data:{"keyword":event.keyword??''} );
    if (response.isSuccess) {
      final model = ProductsData.fromJson(response.response!.data);
      emit(ProductsSuccessState(model: model.list));
    } else {
      emit(ProductsFieldState(message: response.message.toString()));
    }
  }
  String endPoint(ProductType type,{int? id}){
    switch(type){
      case ProductType.favorite:
        return 'client/products/favorites';
      case ProductType.custom:
        return 'products';
       case ProductType.category:
        return '/categories/${id??0}';
    }
  }
}
