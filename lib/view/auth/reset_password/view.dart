import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/design/unit/app_assets.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/app_button.dart';
import 'package:themar/core/design/widget/app_input.dart';
import 'package:themar/core/design/widget/auth_body.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/view/auth/login/view.dart';

import 'bloc.dart';


class ResetPasswordView extends StatefulWidget {
  final String phone;
  final String code;

  const ResetPasswordView({Key? key, required this.phone, required this.code})
      : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {

  @override
  Widget build(BuildContext context) {
    ResetPasswordBloc bloc = BlocProvider.of<ResetPasswordBloc>(context);
    return SafeArea(
      child: Scaffold(
        body: AuthBody(
            widgetForm: BlocBuilder(
              bloc: bloc,
          builder: (BuildContext context,state)=> Form(
                key: bloc.formKey,
                child: Column(
                  children: [
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
                    const SizedBox(height: 16),
                    //rePassword
                    AppInput(
                      autofillHints: const [AutofillHints.password],
                      label: DataString.password,
                      image: DataAssets.iconPassword,
                      isPassword: true,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return DataString.empty(DataString.password);
                        }
                        if (value != bloc.passwordController.text) {
                          return DataString.rePasswordError;
                        }

                        return null;
                      },
                      controller: bloc.rePasswordController,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        text: DataString.resetPasswordButton,
                        onPressed: () {

    bloc.add(ResetPasswordEvent(phone: widget.phone,code: widget.code,));
                        },
                        isLoading: state is ResetPasswordLoadingState,
                      ),
                    ),


                  ],
                ),
              ),
            ),
            title: DataString.forgetTittle,
            subTitle: DataString.resetPasswordSubTittle,
            onPress: () {
              navigateTo(const LoginView());
            }),
      ),
    );
  }
}
