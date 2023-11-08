  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppGridView extends StatelessWidget {
  final int length;
  final Widget? Function(BuildContext, int) widget;
  const AppGridView({Key? key, required this.length, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        itemCount: length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h*1.sh/746.h,
          childAspectRatio: 163 / 250*1.sh/746.h,
        ),
        itemBuilder:widget,
      ),
    );
  }
}
