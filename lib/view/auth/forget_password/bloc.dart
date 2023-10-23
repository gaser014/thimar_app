import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/logic/helper_methods.dart';

import '../../../core/logic/dio_helper.dart';
import '../confirm_code/view.dart';

part 'state.dart';

part 'event.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvents, ForgetPasswordState> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  ForgetPasswordBloc() : super(ForgetPasswordState()) {
    on<ForgetPasswordEvent>(_send);
  }

  Future<void> _send(ForgetPasswordEvent event, Emitter emit) async {
    if (formKey.currentState!.validate()) {
      emit(ForgetPasswordLoadingState());
      final response = await DioHelper().sendData(
        endPoint: "forget_password",
        data: {
          "phone": phoneController.text,
        },
      );
      print(response.response!.data);
      if (response.isSuccess) {
        navigateTo(
            ConfirmCodeView(phone: phoneController.text, isActive: false));
        emit(ForgetPasswordSuccessState());
      } else {
        showMessage(message: response.message);
        emit(ForgetPasswordFailedState());
      }
    }
  }
}
