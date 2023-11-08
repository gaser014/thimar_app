import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_assets.dart';
import 'package:themar/core/logic/cashed_helper.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/view/home/home.dart';

import '../auth/login/view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();

    navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();

    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(DataAssets.imagesBackgroundSplash),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            PositionedDirectional(
              bottom: -29.h,
              end: 60.w,
              width: 448.w,
              height: 298.h,
              child: Image.asset(
                DataAssets.imagesBottomSplash,
fit: BoxFit.cover,              ),
            ),
              FadeInLeft(
                child: Spin(
                  delay:  const Duration(milliseconds: 300),
                child: Swing(
                  delay: const Duration(milliseconds: 500),
                  child: Center(
                    child: Image.asset(
                      DataAssets.imagesLogo,
                      width: 160,
                      height: 160,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
            ),
              ),
          ],
        ),
      ),
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );

    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(milliseconds: 3500),
      () {
    navigateTo(CachedHelper.isAuth()? const LoginView():const HomeView());
      },
    );
  }
}
