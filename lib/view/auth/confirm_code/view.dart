import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/app_button.dart';
import 'package:themar/core/design/widget/auth_body.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/view/auth/login/view.dart';

import 'bloc.dart';

class ConfirmCodeView extends StatefulWidget {
  final String phone;
  final bool isActive;

  const ConfirmCodeView({Key? key, required this.phone, required this.isActive})
      : super(key: key);

  @override
  State<ConfirmCodeView> createState() => _ConfirmCodeViewState();
}

class _ConfirmCodeViewState extends State<ConfirmCodeView> {

  @override
  Widget build(BuildContext context) {
    ConfirmBloc bloc = BlocProvider.of<ConfirmBloc>(context);
    return SafeArea(
      child: Scaffold(
        body: AuthBody(
            widgetForm: BlocBuilder(
              bloc: bloc,
          builder: (BuildContext context,state)=> Form(
                key: bloc.formKey,
                child: Column(
                  children: [
                    PinCodeTextField(
                      controller: bloc.codeController,
                      appContext: context,
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
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        text: DataString.confirmButton,
                        onPressed: () {
                          if(widget.isActive){
                          bloc.add(VerifyEvent(widget.phone));}else{
                            bloc.add(ResetEvent(widget.phone));
                          }
                        },
                        isLoading: state is ConfirmLoadingState,
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      DataString.resendCode,
                      style: TextStyle(
                        color: Color(0xff707070),
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
             state is TimerEnd
                        ? SizedBox(
                            width: 132,
                            height: 48,
                            child: OutlinedButton(
                                onPressed: () {
                                  bloc.add(ResendEvent(widget.phone));
                                },
                                child: Text(
                                  DataString.resendCodeButton,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                          )
                        :state is TimerState? SizedBox(
                            width: 60,
                            height: 60,
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
                                    "${state.currentSecond ~/ 60}:${(state.currentSecond % 60).toString().padLeft(2, '0')}",
                                    style: const TextStyle(
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ):const SizedBox(),
                  ],
                ),
              ),
            ),
            title:widget.isActive? DataString.confirmAccountTittle: DataString.forgetTittle,
            subTitle: DataString.confirmAccountSubTittle,
            phone: widget.phone,
            changePhone: () {
              Navigator.pop(context);
            },
            onPress: () {
              navigateTo(const LoginView());
            }),
      ),
    );
  }
}
