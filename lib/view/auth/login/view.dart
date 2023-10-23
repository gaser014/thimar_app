import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/design/unit/app_assets.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/app_button.dart';
import 'package:themar/core/design/widget/app_input.dart';
import 'package:themar/core/design/widget/auth_body.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/feature/phone_input/view.dart';
import 'package:themar/view/auth/forget_password/view.dart';
import 'package:themar/view/auth/login/bloc.dart';

import 'package:themar/view/auth/register/view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AuthBody(
            widgetForm: Builder(
              builder: (context) {
                LoginBloc bloc = BlocProvider.of<LoginBloc>(context);

                return Form(
                  key: bloc.formKey,
                  child: Column(
                    children: [
                      //phone number
                      PhoneInput(bloc.phoneController),
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 20),
                      //forget password
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                          onPressed: () {
                            navigateTo(const ForgetPasswordView());
                          },
                          child: const Text(
                            DataString.forgetPassword,
                            style: TextStyle(
                              color: Color(0xff707070),
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      //login button
                      BlocBuilder(
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
                );
              }
            ),
            title: DataString.welcomeLoginTittle,
            subTitle: DataString.welcomeSubLoginTittle,
            bottomText: DataString.notHaveAccount,
            bottomTextButton: DataString.register,
            //register button
            onPress: () {
              navigateTo(const RegisterView());
            }),
      ),
    );
  }
}
