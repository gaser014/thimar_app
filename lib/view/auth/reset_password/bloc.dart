import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/logic/dio_helper.dart';
import 'package:themar/core/logic/helper_methods.dart';

import '../../home/home.dart';

part 'state.dart';
part 'event.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvents, ResetPasswordState> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  ResetPasswordBloc() : super(ResetPasswordState()) {
    on<ResetPasswordEvent>(_reset);

  }


  Future<void> _reset(ResetPasswordEvent event, Emitter emit) async {
    if (formKey.currentState!.validate()) {
      emit(ResetPasswordLoadingState());

      final response = await DioHelper().sendData(
        endPoint: 'reset_password',
        data: {
          "code":event.code,
          "phone": event.phone,
          "password": passwordController.text,
        },
      );

      if (response.isSuccess) {
        showMessage(
          message: response.message,
          type: MassageType.success,
        );
        navigateTo( const HomeView());
        emit(ResetPasswordSuccessState());
      } else {
        showMessage(
          message: response.message,
        );
        emit(ResetPasswordFailedState());
      }
    }
  }

}
