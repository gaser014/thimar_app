import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_assets.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/app_input.dart';

class PhoneInput extends StatefulWidget {
  final TextEditingController phoneController;

  const PhoneInput(this.phoneController, {Key? key}) : super(key: key);

  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  late  String countryCode;

  late  String icon;

  @override
  void initState() {
    countryCode = DataString.codeKSA;
    icon = DataAssets.iconsKSA;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppInput(
      onChanged: (value) {

        if(value?.length==11){
          setState(() {
            countryCode = DataString.codeEGY;
            icon = DataAssets.iconsEGY;
          });
        }
        if(value?.length==10||value?.length==12){
          setState(() {
            countryCode = DataString.codeKSA;
            icon = DataAssets.iconsKSA;
          });
      }},
      widget: Container(
        width: 70.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: const Color(0xffF3F3F3)),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                width: 32.w,
                height: 20.h,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(height: 4.h),
              Text(
                countryCode.tr()
                , style: TextStyle(
                color: Theme
                    .of(context)
                    .primaryColor,
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
        if (value?.isEmpty ?? true) {
          return DataString.empty(DataString.phone);

        }else if(value!.length<10||value.length>11){
          return DataString.phoneError;
        }


        return null;
      },
      controller: widget.phoneController,
      keyboardType: TextInputType.phone,
    );
  }


}
