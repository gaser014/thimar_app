import 'package:flutter/material.dart';
import 'package:themar/core/design/widget/image.dart';

class AppInput extends StatefulWidget {
  final String label;
  final String image;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Iterable<String>? autofillHints;
  final Function(String)? onChanged;
  final bool isPassword;
  final Widget? widget;
  final bool isEnable;
final bool isFilled;
  const AppInput({
    Key? key,
    this.onChanged,
    required this.label,
    required this.image,
    required this.validator,
    required this.controller,
    this.isEnable = true,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
    this.widget,
    this.isPassword = false,  this.isFilled=false,
  }) : super(key: key);

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleY: .8,
      child: TextFormField(
        obscureText: widget.isPassword&&isPasswordHidden,
        controller: widget.controller,
        style: widget.isFilled? const TextStyle(
fontSize: 15,
          fontWeight: FontWeight.w300,
          color: Color(0xffB9C9A8),
        ):null,
        autofillHints: widget.autofillHints,
        validator: widget.validator,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        enabled: widget.isEnable,
        decoration: InputDecoration(
          filled: widget.isFilled,
          fillColor: const Color(0xff4C8613).withOpacity(.08),
                hintText : widget.label,
          hintStyle:widget.isFilled?
          TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w300,
            color: Color(0xffB9C9A8),
          )     : const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color(0xffAFAFAF),
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
              : null,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(16.0),
            child: AppImage(
            path:   widget.image,
              width: 20,
              height: 20,
              fit: BoxFit.scaleDown,
            )
          ),
        ),
      ),
    );
  }
}
