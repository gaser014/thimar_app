import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';

part 'states.dart';

part 'events.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvents, ForgetPasswordStates> {
  ForgetPasswordBloc() : super(ForgetPasswordStates()) {
    on<ForgetPasswordEvent>(_send);
  }

  Future<void> _send(
      ForgetPasswordEvent event, Emitter<ForgetPasswordStates> emit) async {
    emit(ForgetPasswordLoadingState());
    final response = await DioHelper()
        .sendData(endPoint: "forget_password", data: event.data);
    debugPrint(response.response?.data.toString());
    if (response.isSuccess) {
      emit(ForgetPasswordSuccessState(
        phone: event.phone,
        isActive: false,
      ));
    } else {
      emit(ForgetPasswordFailedState(error: response.message));
    }
  }
}
