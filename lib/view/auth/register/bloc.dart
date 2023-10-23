import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/logic/dio_helper.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/feature/cities/model.dart';
import 'package:themar/view/auth/confirm_code/view.dart';

part 'state.dart';
part 'event.dart';
class RegisterBloc extends Bloc<RegisterEvents, RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    on<RegisterEvent>(_register);
  }


  CitiesModel? selectedCity;
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
 bool isEG = true;
  Future<void> _register(RegisterEvent event, Emitter<RegisterState> emit) async {
    if (formKey.currentState!.validate()) {
      emit(RegisterLoadingState());
if(phoneController.text.length==10){
  isEG=false;
}
//5354544545
      final response = await DioHelper().sendData(
        endPoint: 'client_register',
        data: {
          "fullname": nameController.text,
          "password": passwordController.text,
          "password_confirmation": rePasswordController.text,
          "phone": phoneController.text,
          "country_id":isEG?null: 1,
          "city_1": selectedCity!.id,
        },
      );

      if (response.isSuccess) {
        showMessage(
          message: response.message,
          type: MassageType.success,
        );
        navigateTo(ConfirmCodeView(phone: phoneController.text, isActive: true));
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
