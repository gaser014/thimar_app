import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/logic/cashed_helper.dart';
import 'package:themar/core/logic/dio_helper.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/view/auth/confirm_code/bloc.dart';
import 'package:themar/view/auth/confirm_code/view.dart';
import 'package:themar/view/auth/login/model.dart';

import '../../home/home.dart';

part 'event.dart';

part 'state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  LoginBloc() : super(LoginState()) {
    on<LoginEvent>(_login);
  }

  Future<void> _login(LoginEvent event, Emitter<LoginState> emit) async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState());

      final response = await DioHelper().sendData(
        endPoint: 'login',
        data: {
          "password": passwordController.text,
          "phone": phoneController.text,
          "type": Platform.operatingSystem,
          "device_token": "test",
          "user_type": "client",
        },
      );
      //42687539510

      if (response.isSuccess) {
        UserModel model = UserModel.fromJson(response.response!.data);

        if (CachedHelper.isActive()) {
          CachedHelper.saveData(model.user);
          print("is active is  ${CachedHelper.isActive()}");
          print("*" * 50);
          showMessage(
            message: response.message,
            type: MassageType.success,
          );

          navigateTo(const HomeView());
          emit(LoginSuccessState());
        }


        else {
          final checkCode = await DioHelper().sendData(
            endPoint: 'resend_code',
            data: {
              "phone": phoneController.text,
            },
          );
          if(checkCode.isSuccess){
            model.user.isActive = true;
            CachedHelper.saveData(model.user);
            showMessage(
              message: response.message,
              type: MassageType.success,
            );

            navigateTo(const HomeView());
            emit(LoginSuccessState());
          }


        else{
            showMessage(
              message: checkCode.message,
            );
            emit(LoginFailedState());
          }
        }
      } else {
        if (response.response?.data['is_active']??true ) {
          showMessage(
            message: response.message,
          );
        } else{
          showMessage(
            type: MassageType.warning,
            message: DataString.activateAccount,
          );
          navigateTo(ConfirmCodeView(
            phone: phoneController.text,
            isActive: true,
          ));
        }
        emit(LoginFailedState());
      }
    }
  }
}
