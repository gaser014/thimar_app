import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/logic/dio_helper.dart';

import 'model.dart';

part 'states.dart';
part 'events.dart';

class CitiesBloc extends Bloc<CitiesEvents, CitiesStates> {
  CitiesBloc() : super(CitiesStates()) {
    on<GetCitiesEvent>(_getCities);
  }
  Future<void> _getCities(
      GetCitiesEvent event, Emitter<CitiesStates> emit) async {
    emit(CitiesLoadingState());
    final response = await DioHelper().getData(endPoint: "cities/1");
    debugPrint(response.response?.data.toString());
    if (response.isSuccess) {
      final model = CitiesData.fromJson(response.response?.data);
      debugPrint(model.list.toString());
      emit(CitiesSuccessState(model: model));
    } else {
      emit(CitiesFailedState(message: "خطأ في الاتصال"));
    }
  }
}
