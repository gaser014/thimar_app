import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/dio_helper.dart';
import 'model.dart';
part 'event.dart';
part 'state.dart';
class ProductsBloc extends Bloc<ProductsEvents, ProductsState> {
  int index = 0;
  ProductsBloc() : super(ProductsState()) {
    on<ProductEvent>(_getProducts);
  }

  Future<void> _getProducts(ProductEvent event, Emitter emit) async {
    emit(ProductsLoadingState());

    final response = await DioHelper().getData(endPoint: 'products');
    if (response.isSuccess) {
      final model = ProductsData.fromJson(response.response!.data);
      emit(ProductsSuccessState(model: model.list));
    }
    else{
      emit(ProductsFieldState(message: response.message.toString()));
    }
  }

}