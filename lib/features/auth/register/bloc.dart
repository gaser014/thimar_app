import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/logic/helper_methods.dart';

import '../../../core/logic/dio_helper.dart';
import '../cities/model.dart';

part 'states.dart';

part 'events.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterStates> {
  RegisterBloc() : super(RegisterStates()) {
    on<RegisterEvent>(_register);
  }

  Future<void> _register(
      RegisterEvent event, Emitter<RegisterStates> emit) async {
    emit(RegisterLoadingState());

//5354544545
    final response = await DioHelper()
        .sendData(endPoint: 'client_register', data: event.data);

    if (response.isSuccess) {
      emit(RegisterSuccessState(
        message: response.message,
        phone: event.phone,
        isActivated: true,
      ));
    } else {
      emit(RegisterFailedState(
        message: response.message,
      ));
    }
  }
}
