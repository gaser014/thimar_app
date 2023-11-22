import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/widget/image.dart';
import '../../core/design/unit/app_assets.dart';
import '../../core/design/unit/app_string.dart';
import 'pages/main/view.dart';
import 'pages/my_account/view.dart';
import 'pages/my_favorite/view.dart';
import 'pages/notification/view.dart';
import 'pages/order/view.dart';
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Widget> items = [
    const MainPage(),
    OrderPage(),
    const NotificationPage(),
    const MyFavPage(),
    const MyAccount(),
  ];
  final List<String> label =  [
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

late  int _currentIndex ;
@override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: items[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: const Color(0xffAED489),
        selectedItemColor: Colors.white,
        items:  List.generate(
            items.length,
                (index) => BottomNavigationBarItem(
              icon: AppImage(
                path: icon[index],
                fit: BoxFit.scaleDown,
                height: 20.h,
                width: 20.w,
                color: _currentIndex == index
                    ? Colors.white
                    : const Color(0xffAED489),
              ),
              label: label[index].tr(),
            )),
        selectedLabelStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w800,
            color: Colors.white),
        unselectedLabelStyle: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w800,
            color: const Color(0xffAED489)),
        onTap: (index) {
_currentIndex = index;
          setState(() {});
        },
        currentIndex: _currentIndex,
      ),
    );
  }
}
