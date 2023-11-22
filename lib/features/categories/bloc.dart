import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/logic/helper_methods.dart';
import '../../core/logic/dio_helper.dart';
part  'model.dart';
part 'events.dart';
part 'states.dart';
class CategoriesBloc extends Bloc<CategoriesEvents, CategoriesStates> {
  int index = 0;
  CategoriesBloc() : super(CategoriesStates()) {
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