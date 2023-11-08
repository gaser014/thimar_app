import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/logic/cashed_helper.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/feature/cart/bloc.dart';
import 'package:themar/feature/categories/bloc.dart';
import 'package:themar/feature/cities/bloc.dart';
import 'package:themar/feature/phone_input/cubit.dart';
import 'package:themar/feature/product_details/bloc.dart';
import 'package:themar/feature/products/bloc.dart';
import 'package:themar/view/auth/confirm_code/bloc.dart';
import 'package:themar/view/auth/register/bloc.dart';
import 'package:themar/view/auth/reset_password/bloc.dart';
import 'package:themar/view/home/bloc.dart';
import 'package:themar/feature/slider/bloc.dart';
import 'package:themar/view/intro/view.dart';
import 'view/auth/forget_password/bloc.dart';
import 'view/auth/login/bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CachedHelper.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF4C8613),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<PhoneInputCubit>(
          create: (context) => PhoneInputCubit(),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider<CitiesBloc>(
            create: (context) => CitiesBloc()),
        BlocProvider<ConfirmBloc>(
            create: (context) => ConfirmBloc()..add(TimerEvent())),
        BlocProvider<ForgetPasswordBloc>(
            create: (context) => ForgetPasswordBloc()),
        BlocProvider<ResetPasswordBloc>(
            create: (context) => ResetPasswordBloc()),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<SliderBloc>(
          create: (context) => SliderBloc()
            ..add(
              SliderEvent(),
            ),
        ),
        BlocProvider<CategoriesBloc>(
          create: (context) => CategoriesBloc()
            ..add(
              CategoriesEvent(),
            ),
        ),
        BlocProvider<FavBloc>(create: (context) => FavBloc()),
        BlocProvider<CardBloc>(create: (context) => CardBloc()..add(GetCardEvent())),
        BlocProvider<ProductsBloc>(create: (context) => ProductsBloc())
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Thimar',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // CircularProgressIndicatorThemeData(
            //   color: const Color(0xFF4C8613),
            // ),
            progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: Color(0xFF4C8613),
            ),
            primaryColor: const Color(0xFF4C8613),
            inputDecorationTheme: const InputDecorationTheme(
              // alignLabelWithHint: true,
              labelStyle: TextStyle(
                color: Color(0xffB1B1B1),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(
                  color: Color(0xFF4C8613),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(
                  color: Color(0xFF4C8613),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(
                  color: Color(0xFFf3f3f3),
                ),
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 16),
                ),
                side: MaterialStateProperty.all(
                  const BorderSide(
                    color: Color(0xFF4C8613),
                  ),
                ),
              ),
            ),
            filledButtonTheme: FilledButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFF4C8613),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            buttonTheme: ButtonThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              buttonColor: const Color(0xFF4C8613),
            ),
            primarySwatch: primarySwatch(),
            useMaterial3: true,
          ),
          builder: (context, child) =>
              Directionality(textDirection: TextDirection.rtl, child: child!),
          home: const SplashView(),
          themeMode: ThemeMode.light,
        ),
      ),
    );
  }

  MaterialColor? primarySwatch() {
    Color color = const Color(0xFF4C8613);
    return MaterialColor(color.value, {
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1.0),
    });
  }
}


// flutter build apk --no-tree-shake-icons