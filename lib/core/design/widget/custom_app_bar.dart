import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/app_bar_icon.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/view/home/home.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final  String title;
final  Function()? onTap;
  const CustomAppBar({Key? key,required this.title,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: onTap??() {
navigateTo(HomeView());
              },
              child: const AppBarIcon(),
            ),
            SizedBox(
width: 1.sw-32*3,
              child: Text(
                title.trim(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  Size.fromHeight(70.h);
}
