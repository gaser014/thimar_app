import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/logic/dio_helper.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/view/auth/reset_password/view.dart';

import '../../home/home.dart';

part 'state.dart';
part 'event.dart';
class ConfirmBloc extends Bloc<ConfirmEvent, ConfirmState> {
  final formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();

  ConfirmBloc() : super(ConfirmState()) {
    on<VerifyEvent>(_confirm);
    on<ResendEvent>(_resendCode);
    on<TimerEvent>(_startTimer);
    on<ResetEvent>(_forgetPassword);

  }
  _startTimer(TimerEvent event, Emitter emit) async {
    for (int currentSecond = 90; currentSecond >= 1; currentSecond--) {
      await Future.delayed(const Duration(seconds: 1));
      emit(TimerState(
        currentSecond,
      ));
    }
    emit(TimerEnd());
  }

  Future<void> _confirm(VerifyEvent event, Emitter emit) async {
    if (formKey.currentState!.validate()) {
      emit(ConfirmLoadingState());

      final response = await DioHelper().sendData(
        endPoint: 'verify',
        data: {
          "code":codeController.text ,
          "phone": event.phone,
          "type": Platform.operatingSystem,
          "device_token": "test",
        },
      );

      if (response.isSuccess) {
        showMessage(
          message: response.message,
          type: MassageType.success,
        );
        navigateTo( const HomeView());
        emit(ConfirmSuccessState());
      } else {
        showMessage(
          message: response.message,
        );
        emit(ConfirmFailedState());
      }
    }
  }
  Future<void> _forgetPassword(ResetEvent event, Emitter emit) async {
    if (formKey.currentState!.validate()) {
      emit(ConfirmLoadingState());

      final response = await DioHelper().sendData(
        endPoint: 'check_code',
        data: {
          "code":codeController.text ,
          "phone": event.phone,
        },
      );

      if (response.isSuccess) {

        navigateTo( ResetPasswordView(phone: event.phone, code: codeController.text));
        emit(ConfirmSuccessState());
      } else {
        showMessage(
          message: response.message,
        );
        emit(ConfirmFailedState());
      }
    }
  }
  Future<void> _resendCode(ResendEvent event, Emitter emit) async {
    if (formKey.currentState!.validate()) {
      emit(ConfirmLoadingState());

      final response = await DioHelper().sendData(
        endPoint: 'resend_code',
        data: {
          "phone": event.phone,
        },
      );

      if (response.isSuccess) {
ConfirmBloc().add(TimerEvent());
        emit(ConfirmSuccessState());
      } else {
        showMessage(
          message: response.message,
        );

        emit(ConfirmFailedState());
      }
    }
  }
}
