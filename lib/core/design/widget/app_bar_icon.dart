import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../unit/app_assets.dart';
import 'app_image.dart';

class AppBarIcon extends StatelessWidget {
  final String? path;
  final double width, height;
  final bool isFavorite;
  const AppBarIcon(
      {Key? key,
      this.path,
      this.width = 32,
      this.height = 32,
      this.isFavorite = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withOpacity(.14),
          width: .8.w,
        ),
        color: Theme.of(context).primaryColor.withOpacity(.13),
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: isFavorite
          ? Icon(
              Icons.favorite,
              color: Theme.of(context).primaryColor,
            )
          : AppImage(
              path: path ?? DataAssets.iconBack,
              width: width.w * .5,
              height: height.h * .5,
              color: Theme.of(context).primaryColor,
              fit: BoxFit.scaleDown,
            ),
    );
  }
}
