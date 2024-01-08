import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/logic/cashed_helper.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/features/add_to_fav/bloc.dart';
import 'package:themar/features/auth/confirm_code/bloc.dart';
import 'package:themar/features/cart/bloc.dart';
import 'package:themar/features/location/bloc.dart';
import 'package:themar/features/my_account/bloc.dart';
import 'package:themar/features/products/bloc.dart';
import 'package:themar/features/review/bloc.dart';
import 'package:themar/views/home/pages/main/location/view.dart';
import 'package:themar/views/splash/view.dart';

import 'core/logic/bloc_observer.dart';
import 'core/logic/get_it.dart';
import 'features/add_to_card/bloc.dart';
import 'features/auth/cities/bloc.dart';
import 'features/auth/forget_password/bloc.dart';
import 'features/auth/login/bloc.dart';
import 'features/auth/register/bloc.dart';
import 'features/auth/reset_password/bloc.dart';
import 'features/categories/bloc.dart';
import 'features/slider/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  CachedHelper.init();
  getItServices();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF4C8613),
    ),
  );
  Bloc.observer = AppBlocObserver();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      saveLocale: true,
      useOnlyLangCode: true,
      path: 'assets/lang',
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LocationBloc>()),

//----------------------Auth---------------------

        BlocProvider(create: (context) => getIt<LoginBloc>()),
        BlocProvider(create: (context) => getIt<RegisterBloc>()),
        BlocProvider(
            create: (context) =>
                getIt.get<CitiesBloc>()..add(GetCitiesEvent())),
        BlocProvider(
            create: (context) => getIt<ConfirmBloc>()..add(TimerEvent())),
        BlocProvider(create: (context) => getIt<ForgetPasswordBloc>()),
        BlocProvider(create: (context) => getIt<ResetPasswordBloc>()),
//=====================================================================================
        BlocProvider(
            create: (context) => getIt<SliderBloc>()..add(SliderEvent())),
        BlocProvider(
            create: (context) =>
                getIt<CategoriesBloc>()..add(CategoriesEvent())),
        BlocProvider(create: (context) => getIt<ReviewsBloc>()),

        BlocProvider(create: (context) => getIt<FavBloc>()),
        BlocProvider(create: (context) => getIt<CardBloc>()),
        BlocProvider(create: (context) => getIt<AddToCardBloc>()),
        BlocProvider(create: (context) => getIt<ProductsBloc>()),
//---------------------------------------------------------------------------
        //---setting-----
        BlocProvider(create: (context) => getIt<MyAccountBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: const [
              Locale(
                'en',
              ),
              Locale(
                'ar',
              )
            ],
            locale: context.locale,
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var locale in supportedLocales) {
                if (deviceLocale != null &&
                    deviceLocale.languageCode == locale.languageCode) {
                  return deviceLocale;
                }
              }

              return supportedLocales.first;
            },

            navigatorKey: navigatorKey,
            title: 'Thimar',
            debugShowCheckedModeBanner: false,

            theme: ThemeData(
              dialogBackgroundColor: Colors.white,
              colorScheme:ColorScheme.light(
                primary: Color(0xFF4C8613),
                onPrimary: Colors.white,
                surface:  Color(0xFF4C8613),
                onSurface: Colors.black,
              ),
              fontFamily: 'Tajawal',
              scaffoldBackgroundColor: Colors.white,
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
              timePickerTheme: TimePickerThemeData(
                padding: EdgeInsetsDirectional.all(16.r),
                backgroundColor: Colors.white,
                dialBackgroundColor: Colors.white,
                hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? Colors.white
                    : Color(0xFF4C8613)),

                hourMinuteColor: MaterialStateColor.resolveWith((states) =>
                    states.contains(MaterialState.selected)
                        ? Color(0xFF4C8613)
                        : Colors.white),
                dayPeriodColor: Color(0xFF4C8613),
                dialHandColor: Color(0xFF4C8613).withOpacity(0.5),
                dialTextColor: MaterialStateColor.resolveWith(
                  (states) => states.contains(MaterialState.selected)
                      ? Colors.white
                      : Color(0xFF4C8613),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                helpTextStyle: TextStyle(color: Color(0xFF4C8613)

                ),
entryModeIconColor: Color(0xFF4C8613),
                dayPeriodTextColor: Color(0xFF4C8613),

           confirmButtonStyle: TextButton.styleFrom(
             backgroundColor: Color(0xFF4C8613),
             textStyle: TextStyle(color: Colors.white),
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(8),
             ),
            ),
                cancelButtonStyle: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  textStyle: TextStyle(color: Color(0xFF4C8613)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                )

           ),
datePickerTheme:DatePickerThemeData(
  backgroundColor: Colors.white,

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
            // builder: (context, child) =>
            //     Directionality(textDirection: TextDirection.rtl, child: child!),
            home: const SplashView(),
            themeMode: ThemeMode.light,
          ),
        ),
      ),
    );
  }
}

// flutter build apk --no-tree-shake-icons
