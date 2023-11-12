import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/widget/image.dart';

class AppInput extends StatefulWidget {
  final String label;
  final String? image;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Iterable<String>? autofillHints;
  final Function(String?)? onChanged;
  final bool isPassword;
  final Widget? widget;
  final bool isEnable;
  final bool isFilled;
  final Widget? suffixIcon;

  const AppInput({
    Key? key,
    this.onChanged,
    required this.label,
     this.image,
    required this.validator,
    required this.controller,
    this.isEnable = true,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
    this.widget,
    this.suffixIcon,
    this.isPassword = false,
    this.isFilled = false,
  }) : super(key: key);

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool isPasswordHidden = true;
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleY: .8,
      child: TextFormField(
        obscureText: widget.isPassword && isPasswordHidden,
        controller: widget.controller,
        style: widget.isFilled
            ? TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w300,
                color: const Color(0xffB9C9A8),
              )
            : null,
        autofillHints: widget.autofillHints,
        validator: widget.validator,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: widget.keyboardType,
        onChanged: (value) {
          if (_debounce?.isActive ?? false) _debounce!.cancel();
          _debounce = Timer(Duration(seconds: 1), () {
            widget.onChanged!(value);
          });


        },
        enabled: widget.isEnable,
        decoration: InputDecoration(
          filled: widget.isFilled,
          fillColor: const Color(0xff4C8613).withOpacity(.08),
          hintText: widget.label,
          hintStyle: widget.isFilled
              ? TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xffB9C9A8),
                )
              : TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffAFAFAF),
                ),
          icon: widget.widget,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(isPasswordHidden
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    isPasswordHidden = !isPasswordHidden;
                    setState(() {});
                  },
                )
              : widget.suffixIcon,
          prefixIcon: (widget.image?.isNotEmpty??true)? null:Padding(
              padding: EdgeInsets.all(16.0.r),
              child: AppImage(
                path: widget.image!,
                width: 20.w,
                height: 20.h,
                fit: BoxFit.scaleDown,
              )),
        ),
      ),
    );
  }
}
