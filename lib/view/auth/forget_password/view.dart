import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/app_button.dart';
import 'package:themar/core/design/widget/auth_body.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/view/auth/forget_password/bloc.dart';
import 'package:themar/view/auth/login/view.dart';

import '../../../feature/phone_input/view.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {


  @override
  Widget build(BuildContext context) {
    ForgetPasswordBloc bloc = BlocProvider.of<ForgetPasswordBloc>(context);
    return SafeArea(
      child: Scaffold(
        body: AuthBody(
            widgetForm: Form(
              key: bloc.formKey,
              child: Column(
                children: [
                  PhoneInput(bloc.phoneController),
                  const SizedBox(height: 20),

                  BlocBuilder(
                    bloc: bloc,
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          text: DataString.login,
                          onPressed: () {
                            bloc.add(ForgetPasswordEvent());
                          },
                          isLoading: state is ForgetPasswordLoadingState,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            title: DataString.forgetTittle,
            subTitle: DataString.forgetPasswordSubTittle,

            onPress: () {
              navigateTo(const LoginView());
            }),
      ),
    );
  }
}
