import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/design/unit/app_string.dart';
import '../../../../core/logic/helper_methods.dart';
import '../main/products/view.dart';

class MyFavPage extends StatefulWidget {
  const MyFavPage({Key? key}) : super(key: key);

  @override
  State<MyFavPage> createState() => _MyFavPageState();
}

class _MyFavPageState extends State<MyFavPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _FavAppbar(),
        body: ListView(children: const [
          ProductView(
            type: ProductType.favorite,
          ),
        ]));
  }
}

class _FavAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 70.h,
        child: Center(
          child: Text(
            DataString.myFav.tr(),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.0.h);
}
