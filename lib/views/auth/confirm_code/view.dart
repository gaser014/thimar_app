import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/app_button.dart';
import 'package:themar/views/auth/auth_body.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/features/auth/confirm_code/bloc.dart';
import 'package:themar/views/auth/forget_password/view.dart';
import '../../../core/logic/get_it.dart';
import '../../home/view.dart';
import '../login/view.dart';
import '../reset_password/view.dart';

class ConfirmCodeView extends StatefulWidget {
  final String phone;
  final bool isActive;
  final formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();

  ConfirmCodeView({Key? key, required this.phone, required this.isActive})
      : super(key: key);

  @override
  State<ConfirmCodeView> createState() => _ConfirmCodeViewState();
}

class _ConfirmCodeViewState extends State<ConfirmCodeView> {
  late final ConfirmBloc bloc;

  @override
  void initState() {
    bloc = getIt.get<ConfirmBloc>();
    bloc.add(TimerEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AuthBody(
            widgetForm: BlocConsumer(
              listener: (BuildContext context, state) {
                if (state is ConfirmSuccessState) {
                  debugPrint('ConfirmSuccessState');
                  debugPrint('navigateTo ResetPasswordView');

                  navigateTo(
                      ResetPasswordView(phone: state.phone, code: state.code),
                      removeHistory: true);
                }
                if (state is VerifySuccessState) {
                  debugPrint('VerifySuccessState');
                  debugPrint('navigateTo HomeView');

                  navigateTo(const HomeView(), removeHistory: true);
                }
              },
              bloc: bloc,
              builder: (BuildContext context, state) => Form(
                key: widget.formKey,
                child: Column(
                  children: [
                    PinCodeTextField(
                      controller: widget.codeController,
                      appContext: context,
                      autoDisposeControllers: false,
                      pastedTextStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      blinkWhenObscuring: true,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(15),
                        fieldHeight: 60,
                        fieldWidth: 70,
                        inactiveColor: const Color(0xfff3f3f3),
                        selectedColor: Theme.of(context).primaryColor,
                      ),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return DataString.verifyCodeError;
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        text: DataString.confirmButton,
                        onPressed: () {
                          if (widget.formKey.currentState!.validate()) {
                            if (widget.isActive) {
                              bloc.add(
                                VerifyEvent(
                                  phone: widget.phone,
                                  code: widget.codeController.text,
                                ),
                              );
                            } else {
                              bloc.add(
                                ResetEvent(
                                  phone: widget.phone,
                                  code: widget.codeController.text,
                                ),
                              );
                            }
                          }
                        },
                        isLoading: state is ConfirmLoadingState,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Text(
                      DataString.resendCode.tr(),
                      style: TextStyle(
                        color: const Color(0xff707070),
                        fontWeight: FontWeight.w300,
                        fontSize: 16.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    state is TimerEnd
                        ? SizedBox(
                            width: 132.w,
                            height: 48.h,
                            child: OutlinedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.all(12.r),
                                  ),
                                ),
                                onPressed: () {
                                  bloc.add(ResendEvent(phone: widget.phone));
                                },
                                child: Text(
                                  DataString.resendCodeButton.tr(),
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                          )
                        : state is TimerStartedState
                            ? SizedBox(
                                width: 60.w,
                                height: 60.h,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    CircularProgressIndicator(
                                      value: state.currentSecond / 90,
                                      strokeWidth: 3,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    Center(
                                      child: Text(
                                        "${state.currentSecond ~/ 60}:${(state.currentSecond % 60).toString().padLeft(2, '0')}"
                                            .tr(),
                                        style: TextStyle(
                                          color: const Color(0xff707070),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16.sp,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                  ],
                ),
              ),
            ),
            title: widget.isActive
                ? DataString.confirmAccountTittle
                : DataString.forgetTittle,
            subTitle: DataString.confirmAccountSubTittle,
            phone: widget.phone,
            changePhone: widget.isActive
                ? null
                : () {
                    navigateTo(ForgetPasswordView(), removeHistory: true);
                  },
            onPress: () {
              navigateTo(const LoginView(), removeHistory: true);
            }),
      ),
    );
  }
}
