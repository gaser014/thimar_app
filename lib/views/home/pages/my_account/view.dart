import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/image.dart';

import '../../../../core/design/unit/app_assets.dart';
import '../../../../core/logic/cashed_helper.dart';
import '../../../../core/logic/helper_methods.dart';
import '../../../auth/login/view.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 220.h,
            padding: EdgeInsetsDirectional.only(top: 38.h, bottom: 6.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.r),
                bottomRight: Radius.circular(40.r),
              ),
              color: Theme.of(context).primaryColor,
              image: const DecorationImage(
                image: AssetImage(
                  DataAssets.imagesBackgroundAccount,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Text(
                  DataString.myAccount,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 16.h,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: AppImage(
                    path: CachedHelper.getImageProfile(),
                    fit: BoxFit.contain,
                    height: 72.h,
                    width: 72.w,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  CachedHelper.getFullName(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp),
                ),
                Text(
                  CachedHelper.getPhone(),
                  style: TextStyle(
                      color: const Color(0xffA2D273),
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 16.w, vertical: 10.h),
            child: Container(
              padding: EdgeInsetsDirectional.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 11.r,
                      offset: Offset(0, 11.h),
                      color: Colors.black.withOpacity(0.02)),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  SettingsItems(
                    icon: DataAssets.iconUser,
                    title: DataString.personalInfo,
                    tap: () {},
                  ),
                  Divider(
                    height: 1.h,
                    color: const Color(0xffF6F6F6),
                  ),
                  SettingsItems(
                    icon: DataAssets.iconWallet,
                    title: DataString.wallet,
                    tap: () {},
                  ),
                  Divider(
                    height: 1.h,
                    color: const Color(0xffF6F6F6),
                  ),
                  SettingsItems(
                    icon: DataAssets.iconLocation,
                    title: DataString.address,
                    tap: () {},
                  ),
                  Divider(
                    height: 1.h,
                    color: const Color(0xffF6F6F6),
                  ),
                  SettingsItems(
                    icon: DataAssets.iconDollar,
                    title: DataString.payment,
                    tap: () {},
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 16.w, vertical: 10.h),
            child: Container(
              padding: EdgeInsetsDirectional.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 11.r,
                      offset: Offset(0, 11.h),
                      color: Colors.black.withOpacity(0.02)),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  SettingsItems(
                    icon: DataAssets.iconQuestion,
                    title: DataString.faq,
                    tap: () {},
                  ),
                  Divider(
                    height: 1.h,
                    color: const Color(0xffF6F6F6),
                  ),
                  SettingsItems(
                    icon: DataAssets.iconShieldCheck,
                    title: DataString.privacy,
                    tap: () {},
                  ),
                  Divider(
                    height: 1.h,
                    color: const Color(0xffF6F6F6),
                  ),
                  SettingsItems(
                    icon: DataAssets.iconCallCalling,
                    title: DataString.contactUs,
                    tap: () {},
                  ),
                  Divider(
                    height: 1.h,
                    color: const Color(0xffF6F6F6),
                  ),
                  SettingsItems(
                    icon: DataAssets.iconEdit,
                    title: DataString.complaint,
                    tap: () {},
                  ),
                  Divider(
                    height: 1.h,
                    color: const Color(0xffF6F6F6),
                  ),
                  SettingsItems(
                    icon: DataAssets.iconShared,
                    title: DataString.share,
                    tap: () {},
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 16.w, vertical: 10.h),
            child: Container(
              padding: EdgeInsetsDirectional.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 11.r,
                      offset: Offset(0, 11.h),
                      color: Colors.black.withOpacity(0.02)),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  SettingsItems(
                    icon: DataAssets.iconInfo,
                    title: DataString.about,
                    tap: () {},
                  ),
                  Divider(
                    height: 1.h,
                    color: const Color(0xffF6F6F6),
                  ),
                  SettingsItems(
                    icon: DataAssets.iconLanguage,
                    title: DataString.changeLanguage,
                    tap: () {
                      context.setLocale(
                         CachedHelper.getCachedLanguageCode() == 'en'
                              ? const Locale('ar')
                              : const Locale('en',));
                      CachedHelper.cacheLanguageCode(context.locale.languageCode);
                      setState(() {
                        print(context.locale.languageCode);
                        print(CachedHelper.getCachedLanguageCode());
                      });
                    },
                  ),
                  Divider(
                    height: 1.h,
                    color: const Color(0xffF6F6F6),
                  ),
                  SettingsItems(
                    icon: DataAssets.iconNote,
                    title: DataString.terms,
                    tap: () {},
                  ),
                  Divider(
                    height: 1.h,
                    color: const Color(0xffF6F6F6),
                  ),
                  SettingsItems(
                    icon: DataAssets.iconStarAccount,
                    title: DataString.rate,
                    tap: () {},
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 16.w, vertical: 10.h),
            child: Container(
              padding: EdgeInsetsDirectional.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 11.r,
                      offset: Offset(0, 11.h),
                      color: Colors.black.withOpacity(0.02)),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 16.w, end: 9),
                child: Row(
                  children: [
                    Text(
                      DataString.logout.tr(),
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(end: 12.w),
                        child: const AppImage(
                          path: DataAssets.iconTurnOff,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      onTap: () {
                        CachedHelper.clear();
                        navigateTo(const LoginView());
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsItems extends StatelessWidget {
  final String? navigateIcon;
  final String icon, title;
  final void Function()? tap;

  const SettingsItems({
    super.key,
    required this.icon,
    required this.title,
    this.navigateIcon,
    required this.tap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: 16.h),
      child: SizedBox(
        height: 20.h,
        child: Row(
          children: [
            Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 16.w,
                  end: 9.w,
                ),
                child: AppImage(path: icon, fit: BoxFit.scaleDown)),
            Text(
              title.tr(),
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const Spacer(),
            InkWell(
              child: Padding(
                padding: EdgeInsetsDirectional.only(end: 12.w),
                child: AppImage(
                  path: navigateIcon ?? DataAssets.iconArrowLeft,
                  fit: BoxFit.scaleDown,
                ),
              ),
              onTap: tap,
            )
          ],
        ),
      ),
    );
  }
}
