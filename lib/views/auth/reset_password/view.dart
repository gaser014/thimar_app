import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_assets.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/app_button.dart';
import 'package:themar/core/design/widget/app_input.dart';
import 'package:themar/views/auth/auth_body.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/views/auth/login/view.dart';

import '../../../core/logic/get_it.dart';
import '../../../features/auth/reset_password/bloc.dart';
import '../../home/view.dart';

class ResetPasswordView extends StatefulWidget {
  final String phone;
  final String code;

  const ResetPasswordView({Key? key, required this.phone, required this.code})
      : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  late final ResetPasswordBloc bloc;
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  @override
  void initState() {
    bloc = getIt<ResetPasswordBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AuthBody(
            widgetForm: BlocConsumer(
              listener: (context, state) {
                if (state is ResetPasswordSuccessState) {
                  navigateTo(const HomeView());
                }
              },
              bloc: bloc,
              builder: (BuildContext context, state) => Form(
                key: formKey,
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
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 16.h),
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
                        if (value != passwordController.text) {
                          return DataString.rePasswordError;
                        }

                        return null;
                      },
                      controller: rePasswordController,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        text: DataString.resetPasswordButton,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            bloc.add(ResetPasswordEvent(
                              phone: widget.phone,
                              code: widget.code,
                              password: passwordController.text,
                            ));
                          }
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
