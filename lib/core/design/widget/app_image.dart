import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themar/core/design/widget/app_bar_icon.dart';

class AppImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;

  const AppImage({
    Key? key,
    required this.path,
    this.width,
    this.height,
    required this.fit,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (BuildContext context, obj, l) => const AppBarIcon(),
      );
    }
    if (path.endsWith('.svg')) {
      return Transform.flip(
        flipX: context.locale == const Locale('en'),
        child: SvgPicture.asset(
          path,
          fit: fit,
          width: width,
          height: height,
          // ignore: deprecated_member_use
          color: color,
        ),
      );
    } else {
      return Image.asset(
        path,
        fit: fit,
        width: width,
        height: height,
      );
    }
  }
}
