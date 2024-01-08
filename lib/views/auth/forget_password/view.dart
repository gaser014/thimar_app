import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/app_button.dart';
import 'package:themar/views/auth/auth_body.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/features/auth/forget_password/bloc.dart';
import 'package:themar/views/auth/confirm_code/view.dart';
import 'package:themar/views/auth/login/view.dart';
import 'package:themar/views/auth/phone_input/view.dart';

import '../../../core/logic/get_it.dart';

class ForgetPasswordView extends StatefulWidget {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  ForgetPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  late final ForgetPasswordBloc bloc;

  @override
  void initState() {
    bloc = getIt<ForgetPasswordBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AuthBody(
          widgetForm: Form(
            key: widget.formKey,
            child: Column(
              children: [
                PhoneInput(phoneController: widget.phoneController),
                SizedBox(height: 20.h),
                BlocConsumer(
                  listener: (context, state) {
                    if (state is ForgetPasswordSuccessState) {
                      navigateTo(
                        ConfirmCodeView(
                          phone: widget.phoneController.text,
                          isActive: false,
                        ),
                        removeHistory: true,
                      );
                    }
                  },
                  bloc: bloc,
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        text: DataString.login,
                        onPressed: () {
                          if (widget.formKey.currentState!.validate()) {
                            bloc.add(ForgetPasswordEvent(
                                phone: widget.phoneController.text));
                          }
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
            navigateTo(const LoginView(), removeHistory: true);
          },
        ),
      ),
    );
  }
}
