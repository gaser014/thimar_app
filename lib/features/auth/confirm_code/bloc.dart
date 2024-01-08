import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/logic/dio_helper.dart';
import 'package:themar/core/logic/helper_methods.dart';

import '../../../core/logic/cashed_helper.dart';
import '../login/model.dart';

part 'states.dart';

part 'events.dart';

class ConfirmBloc extends Bloc<ConfirmEvents, ConfirmStates> {
  ConfirmBloc() : super(ConfirmStates()) {
    on<VerifyEvent>(_confirm);
    on<ResendEvent>(_resendCode);
    on<TimerEvent>(_startTimer);
    on<ResetEvent>(_forgetPassword);
  }

  _startTimer(TimerEvent event, Emitter<ConfirmStates> emit) async {
    for (int currentSecond = 90; currentSecond >= 1; currentSecond--) {
      await Future.delayed(const Duration(seconds: 1));
      emit(TimerStartedState(
        currentSecond: currentSecond,
      ));
    }
    emit(TimerEnd());
  }

  Future<void> _confirm(VerifyEvent event, Emitter<ConfirmStates> emit) async {
    emit(ConfirmLoadingState());

    final response =
        await DioHelper().sendData(endPoint: 'verify', data: event.data);
    if (response.isSuccess) {
      final model = UserModel.fromJson(response.response!.data);

      model.user.isActive = true;
      CachedHelper.saveData(model: model.user);

      emit(VerifySuccessState(
        message: response.message,
      ));
    } else {
      if (response.response?.data['is_active'] ?? true) {
        emit(ConfirmFailedState(message: response.message));
      } else {
        emit(ConfirmFailedState(message: response.message));
      }
    }
  }

  Future<void> _forgetPassword(
      ResetEvent event, Emitter<ConfirmStates> emit) async {
    emit(ConfirmLoadingState());

    final response =
        await DioHelper().sendData(endPoint: 'check_code', data: event.data);

    if (response.isSuccess) {
      emit(ConfirmSuccessState(
        message: response.message,
        phone: event.phone,
        code: event.code,
      ));
    } else {
      emit(ConfirmFailedState(message: response.message));
    }
  }

  Future<void> _resendCode(
      ResendEvent event, Emitter<ConfirmStates> emit) async {
    emit(ConfirmLoadingState());
    final response = await DioHelper().sendData(
      endPoint: 'resend_code',
      data: {
        "phone": event.phone,
      },
    );

    if (response.isSuccess) {
      add(TimerEvent());
      emit(ResendSuccessState(
        message: response.message,
      ));
    } else {
      emit(ConfirmFailedState(message: response.message));
    }
  }
}
