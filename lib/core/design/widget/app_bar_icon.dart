import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../unit/app_assets.dart';
import 'image.dart';

class AppBarIcon extends StatelessWidget {
  final String path;
final double width,height;
final Widget? icon;
const AppBarIcon({Key? key, this.path=DataAssets.iconBack,this.width=32,this.height=32,this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        border: Border.all(
          color:  Colors.black.withOpacity(.14),
        ),
        color: const Color(0x224C8613),
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: icon?? AppImage(
        path: path,
        width: width.w*.5,
        height: height.h*.5,
        color: Theme.of(context).primaryColor,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
