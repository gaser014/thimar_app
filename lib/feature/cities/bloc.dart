import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/logic/dio_helper.dart';

import 'model.dart';

part 'state.dart';
part 'event.dart';
class CitiesBloc extends Bloc<CitiesEvents,CitiesState> {
  CitiesBloc() : super(CitiesState()){
    on<GetCitiesEvent>(_getCities);
  }
  Future<void> _getCities(GetCitiesEvent event,Emitter<CitiesState> emit) async {
    emit(CitiesLoadingState());
    final response = await DioHelper().getData(endPoint: "cities/1");
    print(response.response?.data);
    if (response.isSuccess) {
     final model = CitiesData.fromJson(response.response!.data);
      print(model.list);
      emit(CitiesSuccessState(model: model));
    } else {
      emit(CitiesFailedState("خطأ في الاتصال"));
    }
  }
}
