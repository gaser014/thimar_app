import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_assets.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/image.dart';

class AuthBody extends StatefulWidget {
  final Widget widgetForm;
  final String title;
  final String subTitle;
  final String? bottomText;
  final String? bottomTextButton;
  final void Function()? onPress;
  final String? phoneChanged;
  final String? phone;
  final void Function()? changePhone;

  const AuthBody({
    Key? key,
    required this.widgetForm,
    required this.title,
    required this.subTitle,
    this.bottomText ,
    this.bottomTextButton ,
    this.phone,
    this.onPress,
    this.phoneChanged ,
    this.changePhone,
  }) : super(key: key);

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(DataAssets.imagesBackgroundSplash),
          fit: BoxFit.fill,
          opacity: .1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),
                Center(
                  child: AppImage(
                    fit: BoxFit.contain,
                    width: 130.w,
                    height: 125.h,
                    path: DataAssets.imagesLogo,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.title.tr(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.subTitle.tr(
                  ),
                  style: TextStyle(
                    color: Color(0xff707070),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                widget.phone == null
                    ? const SizedBox()
                    : SizedBox(
                        height: 24.h,
                        child: Row(
                          children: [
                            Text(
                              widget.phone!,
                              style: TextStyle(
                                color: Color(0xff707070),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            widget.changePhone == null

                                ? const SizedBox()
                                : InkWell(
                                    onTap: widget.changePhone,
                                    child: Text(
                                      (   widget.phoneChanged??DataString.changePhone).tr(),
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                SizedBox(height: 24.h),
                widget.widgetForm,
                SizedBox(height: 48.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (widget.bottomText?? DataString.haveAccount).tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: widget.onPress,
                      child: Text(
                        ( widget.bottomTextButton?? DataString.login) .tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
