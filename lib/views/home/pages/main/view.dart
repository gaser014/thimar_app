import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:themar/features/location/bloc.dart';
import 'package:themar/features/location/model.dart';
import 'package:themar/views/home/pages/main/location/widget/Show_all_address.dart';
import '../../../../core/design/unit/app_assets.dart';
import '../../../../core/design/unit/app_string.dart';
import '../../../../core/design/widget/app_input.dart';
import '../../../../core/design/widget/app_image.dart';
import '../../../../core/logic/get_it.dart';
import '../../../../features/products/bloc.dart';
import 'cart/widget/badge.dart';
import 'categories/view.dart';
import 'location/widget/sheet.dart';
import 'products/view.dart';
import 'slider/view.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final searchController = TextEditingController();
  late final ProductsBloc bloc;

  @override
  void initState() {
    bloc = getIt<ProductsBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _MainAppbar(),
      body: Center(
        child: ListView(
          children: [
            //search
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: BlocBuilder(
                bloc: bloc,
                builder: (context, state) => AppInput(
                  isFilled: true,
                  label: DataString.search,
                  image: DataAssets.iconSearch,
                  validator: (value) {
                    return null;
                  },
                  onChanged: (value) async {
                    bloc.add(ProductEvent(keyword: value));
                    setState(() {});
                  },
                  controller: searchController,
                ),
              ),
            ),
            SizedBox(height: 16.h * 1.sh / 746.h),

            searchController.text.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //slider
                      const SliderView(),
                      SizedBox(
                        height: 16.h * 1.sh / 746.h,
                      ),
                      //categories_title
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          DataString.sections.tr(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      //categories
                      SizedBox(width: 1.sw, child: const CategoriesView()),
                      SizedBox(
                        height: 16.h * 1.sh / 746.h,
                      ),
                    ],
                  )
                : const SizedBox(),
            //items_title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                DataString.items.tr(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 15.sp,
                ),
              ),
            ),
            //items
            ProductView(keyword: searchController.text),

            SizedBox(
              height: 16.h * 1.sh / 746.h,
            ),
          ],
        ),
      ),
    );
  }
}

class _MainAppbar extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<_MainAppbar> createState() => _MainAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(70.0.h * 1.sh / 746.h);
}

class _MainAppbarState extends State<_MainAppbar> {
  late final LocationBloc bloc;
String location='loading';

  @override
  void initState() {
    bloc = getIt<LocationBloc>();
    bloc.add(GetCurrentLocationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        height: 70.h * 1.sh / 746.h,
        child: Row(
          children: [
            AppImage(
              path: DataAssets.imagesLogo,
              width: 20.w,
              height: 20.h * 1.sh / 746.h,
              fit: BoxFit.scaleDown,
            ),
            SizedBox(width: 2.w),
            Text(
              DataString.cart.tr(),
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
            BlocConsumer(
              bloc: bloc,
              listener: (context, state) async {
                if (state is CurrentLocationSuccessState) {
                  List<Placemark> placeMarks = await placemarkFromCoordinates(
                      state.position.latitude, state.position.longitude);

               location = placeMarks.first.locality.toString();
                }
              },
              builder: (context, state) => Expanded(
                child: InkWell(
                  onTap: () async {
                    if(state is CurrentLocationSuccessState){
                 LocationModel? result=   await showModalBottomSheet(
                        context: context,
                        builder: (context) => const LocationSheet());
                 if (result != null) {
                   location = result.location;
                   setState(() {});
                 }}
                  },
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      text: '  ${DataString.delivery.tr()}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).primaryColor,
                      ),
                      children: [
                        const TextSpan(text: "\n"),
                        TextSpan(
                          text:location,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 32.w,
            ),
            const CartBadgeView(),
          ],
        ),
      ),
    );
  }
}
