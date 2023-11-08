import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/logic/dio_helper.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/feature/cities/model.dart';
import 'package:themar/view/auth/confirm_code/view.dart';

import '../../../core/design/unit/app_assets.dart';
import '../../../core/design/unit/app_string.dart';
import '../../../core/design/widget/app_button.dart';
import '../../../core/design/widget/app_input.dart';
import '../../../core/design/widget/auth_body.dart';
import '../../../feature/cities/view.dart';
import '../../../feature/phone_input/view.dart';
import '../login/view.dart';

part 'state.dart';
part 'event.dart';
part 'view.dart';
class RegisterBloc extends Bloc<RegisterEvents, RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    on<RegisterEvent>(_register);
  }


  CitiesModel? selectedCity;
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
 bool isEG = true;
  Future<void> _register(RegisterEvent event, Emitter<RegisterState> emit) async {
    if (_formKey.currentState!.validate()) {
      emit(RegisterLoadingState());
if(_phoneController.text.length==10){
  isEG=false;
}
//5354544545
      final response = await DioHelper().sendData(
        endPoint: 'client_register',
        data: {
          "fullname": _nameController.text,
          "password": _passwordController.text,
          "password_confirmation": rePasswordController.text,
          "phone": _phoneController.text,
          "country_id":isEG?null: 1,
          "city_1": selectedCity!.id,
        },
      );

      if (response.isSuccess) {
        showMessage(
          message: response.message,
          type: MassageType.success,
        );
        navigateTo(ConfirmCodeView(phone: _phoneController.text, isActive: true));
        emit(RegisterSuccessState());
      } else {
        showMessage(
          message: response.message,
        );
        emit(RegisterFailedState());
      }
    }
  }
}
