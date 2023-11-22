import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_assets.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/app_button.dart';
import 'package:themar/core/design/widget/app_input.dart';
import 'package:themar/views/auth/auth_body.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/features/auth/login/bloc.dart';
import 'package:themar/views/auth/forget_password/view.dart';
import 'package:themar/views/auth/phone_input/view.dart';
import 'package:themar/views/home/view.dart';

import '../../../core/logic/get_it.dart';
import '../confirm_code/view.dart';
import '../register/view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginBloc bloc;

  @override
  void initState() {
    bloc =getIt<LoginBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AuthBody(
            widgetForm: Form(
              key: bloc.formKey,
              child: Column(
                children: [
                  //phone number
                  PhoneInput(bloc.phoneController),
                  SizedBox(height: 16.h),
                  //password
                  AppInput(
                    autofillHints: const [AutofillHints.password],
                    label: DataString.password,
                    image: DataAssets.iconPassword,
                    isPassword: true,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return DataString.empty(DataString.password);
                      }
                      if (value!.length < 7) {
                        return DataString.passwordError;
                      }

                      return null;
                    },
                    controller: bloc.passwordController,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 20.h),
                  //forget password
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: () {
                        navigateTo( ForgetPasswordView(),removeHistory: true);
                      },
                      child: Text(
                        DataString.forgetPassword.tr(),
                        style: TextStyle(
                          color: const Color(0xff707070),
                          fontWeight: FontWeight.w300,
                          fontSize: 16.sp,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  //login button
                  BlocConsumer(
                    listener: (context, state) {
                      if (state is LoginSuccessState) {
                        navigateTo(const HomeView());
                      } else if (state is LoginFailedState) {
                        if (state.type == MassageType.warning) {
                          navigateTo(
                            ConfirmCodeView(
                              phone: bloc.phoneController.text,
                              isActive: true,
                            ),removeHistory: true
                          );
                    //4544121242064545
                        }
                      }
                    },
                    bloc: bloc,
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          text: DataString.login,
                          onPressed: () {
                            bloc.add(LoginEvent());
                          },
                          isLoading: state is LoginLoadingState,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            title: DataString.welcomeLoginTittle,
            subTitle: DataString.welcomeSubLoginTittle,
            bottomText: DataString.notHaveAccount,
            bottomTextButton: DataString.register,
            //register button
            onPress: () {
              navigateTo(const RegisterView(),removeHistory: true);
            }),
      ),
    );
  }
}
