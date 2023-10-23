import 'package:flutter/material.dart';
import 'package:themar/core/design/unit/app_assets.dart';
import 'package:themar/core/design/unit/app_string.dart';

class AuthBody extends StatefulWidget {
  final Widget widgetForm;
  final String title;
  final String subTitle;
  final String bottomText;
  final String bottomTextButton;
  final void Function()? onPress;
  final String? phoneChanged;
  final String? phone;
  final void Function()? changePhone;

  const AuthBody({
    Key? key,
    required this.widgetForm,
    required this.title,
    required this.subTitle,
    this.bottomText = DataString.haveAccount,
    this.bottomTextButton = DataString.login,
    this.phone,
    this.onPress,
    this.phoneChanged = DataString.changePhone,
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
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Center(
                  child: Image.asset(
                    DataAssets.imagesLogo,
                    width: 130,
                    height: 125,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.subTitle,
                  style: const TextStyle(
                    color: Color(0xff707070),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                widget.phone == null
                    ? const SizedBox()
                    : SizedBox(
                        height: 24,
                        child: Row(
                          children: [
                            Text(
                              widget.phone!,
                              style: const TextStyle(
                                color: Color(0xff707070),
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              textDirection: TextDirection.ltr,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: widget.changePhone,
                              child: Text(
                                widget.phoneChanged!,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                const SizedBox(height: 24),
                widget.widgetForm,
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.bottomText,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: widget.onPress,
                      child: Text(
                        widget.bottomTextButton,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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
