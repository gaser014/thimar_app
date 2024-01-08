import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final bool isLoading;
  final FontWeight fontWeight;
  final double fontSize;

  const AppButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.isLoading = false,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          )
        : FilledButton(
            onPressed: onPressed,
            child: Text(
              text.tr(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: fontWeight,
                fontSize: fontSize.sp,
              ),
            ),
          );
  }
}
