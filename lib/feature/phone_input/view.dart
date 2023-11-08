import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_assets.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/app_input.dart';
import 'package:themar/feature/phone_input/cubit.dart';

class PhoneInput extends StatefulWidget {
  final TextEditingController phoneController;

  const PhoneInput(this.phoneController, {Key? key}) : super(key: key);

  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneInputCubit, PhoneInputState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<PhoneInputCubit>(context);
        return AppInput(
          onChanged: (value) {
            cubit.change(widget.phoneController.text.length);
          },
          widget: Container(
            width: 70.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: Color(0xffF3F3F3)),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    state is PhoneInputStateChange
                        ? state.icon
                        : DataAssets.iconsKSA,
                    width: 32.w,
                    height: 20.h,
                    fit: BoxFit.scaleDown,
                  ),
                   SizedBox(height: 4.h),
                  Text(
                    state is PhoneInputStateChange
                        ? state.countryCode
                        : DataString.codeKSA,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          autofillHints: const [AutofillHints.telephoneNumber],
          label: DataString.phone,
          image: DataAssets.iconPhone,
          validator: (String? value) {
            if (state is PhoneInputStateError) {
              return state.message;
            }
            if (value?.isEmpty ?? true) {
              return DataString.empty(DataString.phone);
            }
            return null;
          },
          controller: widget.phoneController,
          keyboardType: TextInputType.phone,
        );
      },
    );
  }
}
