import 'package:get_it/get_it.dart';
import 'package:themar/features/add_to_card/bloc.dart';
import 'package:themar/features/add_to_fav/bloc.dart';
import 'package:themar/features/auth/cities/bloc.dart';
import 'package:themar/features/auth/confirm_code/bloc.dart';
import 'package:themar/features/auth/forget_password/bloc.dart';
import 'package:themar/features/auth/login/bloc.dart';
import 'package:themar/features/auth/register/bloc.dart';
import 'package:themar/features/auth/reset_password/bloc.dart';
import 'package:themar/features/cart/bloc.dart';
import 'package:themar/features/categories/bloc.dart';
import 'package:themar/features/products/bloc.dart';
import 'package:themar/features/review/bloc.dart';
import 'package:themar/features/slider/bloc.dart';

import '../../features/localization/app_localizations.dart';
import '../../features/localization/locale_cubit.dart';

var getIt= GetIt.instance;
void getItServices(){
  getIt.registerSingleton<AppLocalizations>(AppLocalizations());
  getIt.registerFactory<LocaleCubit>(()=>LocaleCubit());

  //Auth
  getIt.registerFactory<CitiesBloc>(()=>CitiesBloc());
  getIt.registerFactory<RegisterBloc>(()=>RegisterBloc());
  getIt.registerFactory<LoginBloc>(()=>LoginBloc());
  getIt.registerFactory<ForgetPasswordBloc>(()=>ForgetPasswordBloc());
  getIt.registerFactory<ConfirmBloc>(()=>ConfirmBloc());
  getIt.registerFactory<ResetPasswordBloc>(()=>ResetPasswordBloc());
//==============================================================================================================
//----home------
getIt.registerFactory<SliderBloc>(()=>SliderBloc());
  getIt.registerFactory<CategoriesBloc>(()=>CategoriesBloc());
  getIt.registerFactory<ReviewsBloc>(()=>ReviewsBloc());
  getIt.registerFactory<FavBloc>(()=>FavBloc());
  getIt.registerSingleton<CardBloc>(CardBloc());
  getIt.registerFactory<AddToCardBloc>(()=>AddToCardBloc());
  getIt.registerFactory<ProductsBloc>(()=>ProductsBloc());


}