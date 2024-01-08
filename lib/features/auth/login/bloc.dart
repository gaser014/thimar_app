import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/logic/cashed_helper.dart';
import 'package:themar/core/logic/dio_helper.dart';
import 'package:themar/core/logic/helper_methods.dart';

import 'model.dart';

part 'events.dart';

part 'states.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginBloc() : super(LoginStates()) {
    on<LoginEvent>(_login);
  }

  Future<void> _login(LoginEvent event, Emitter<LoginStates> emit) async {
    emit(LoginLoadingState());

    final response = await DioHelper().sendData(
      endPoint: 'login',
      data: event.data,
    );
    //42687539510

    if (response.isSuccess) {
      final model = UserModel.fromJson(response.response!.data);

      model.user.isActive = true;
      CachedHelper.saveData(model: model.user);

      emit(LoginSuccessState(
        message: response.message,
      ));
    } else {
      if (response.response?.data['is_active'] ?? true) {
        emit(LoginFailedState(
          msg: response.message,
        ));
      } else {
        emit(LoginFailedState(
          msg: DataString.activateAccount,
          type: MassageType.warning,
        ));
      }
    }
  }
}
