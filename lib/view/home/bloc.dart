import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themar/core/design/widget/app_input.dart';
import 'package:themar/core/design/widget/image.dart';
import 'package:themar/feature/categories/bloc.dart';
import 'package:themar/feature/categories/model.dart';
import 'package:themar/feature/products/bloc.dart';
import 'package:themar/feature/slider/bloc.dart';

import '../../core/design/unit/app_assets.dart';
import '../../core/design/unit/app_string.dart';
import '../../core/design/widget/app_button.dart';
import '../../feature/products/model.dart';

part 'state.dart';

part 'event.dart';

// notification_page
part 'page/notification/view.dart';

// main_page
part 'page/main_page/view.dart';

// profile_page
part 'page/my_account/view.dart';

// favorite_page
part 'page/my_favorite/view.dart';

// order_page
part 'page/order/view.dart';

part 'page/order/model.dart';

part '../../core/design/widget/order_list.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  int _currentIndex = 0;
  final List<Widget> items = [
     _MainPage(),
    _OrderPage(),
    const _NotificationPage(),
    const _MyFavPage(),
    const _MyAccount(),
  ];
  final List<String> label = const [
    DataString.home,
    DataString.order,
    DataString.notification,
    DataString.favorite,
    DataString.myAccount,
  ];
  final List<String> icon = const [
    DataAssets.iconHome,
    DataAssets.iconOrder,
    DataAssets.iconNotification,
    DataAssets.iconFavorite,
    DataAssets.iconMyAccount,
  ];

  HomeBloc() : super(HomeState()) {
    on<HomeEvent>(_changeBottomNavBar);
  }

  List<BottomNavigationBarItem> list() {
    return List.generate(
        items.length,
        (index) => BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icon[index],
                height: 20,
                width: 20,
                color: _currentIndex == index
                    ? Colors.white
                    : const Color(0xffAED489),
              ),
              label: label[index],
            ));
  }

  _changeBottomNavBar(HomeEvent event, Emitter<HomeState> emit) {
    _currentIndex = event.index;
    emit(HomeBottomNavState(
      index: _currentIndex,
      body: items[_currentIndex],
    ));
  }
}
