import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_assets.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/custom_app_bar.dart';
import 'package:themar/core/design/widget/image.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/feature/cart/bloc.dart';

import '../../core/design/widget/app_bar_icon.dart';

class CartView extends StatefulWidget {
  final CardData model;

  const CartView(this.model, {Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<CardBloc>(context).add(GetCardEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: DataString.myCart),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: ListView(
          children: [
            ...List.generate(
              widget.model.list.isEmpty ? 0 : widget.model.list.length,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Container(
                  height: 98.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 17.r,
                        offset: Offset(0, 6.h),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0.r),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppImage(
                            path: widget.model.list[index].image,
                            width: 92.w,
                            height: 78.h,
                            fit: BoxFit.cover),
                        SizedBox(width: 8.w),
                        Column(
                          children: [
                            Text.rich(
                              TextSpan(
                                  text: widget.model.list[index].title,
                                  children: [
                                    const TextSpan(
                                      text: '\n',
                                    ),
                                    TextSpan(
                                      text: "${widget.model.list[index].price}ر.س",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ]),
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),

                            Container(
                              width: 72.h,
                              height: 28.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.r),
                                color: const Color(0xff4C8613).withOpacity(.11),
                              ),
                              padding: EdgeInsetsDirectional.all(
                               2.r,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      width: 24.w,
                                      height: 24.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text("1",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).primaryColor,
                                      )),
                                  GestureDetector(
                                    child: Container(
                                      width: 24.w,
                                      height: 24.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Center(
                                          child: Icon(
                                            Icons.remove,
                                            color: Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
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
}

class CartBadgeView extends StatelessWidget {
  const CartBadgeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardBloc, CardState>(
      builder: (BuildContext context, CardState state) {
        if (state is CardLoadingState) {
          return const AppBarIcon(
            path: DataAssets.iconCart,
          );
        } else if (state is CardSuccessState) {
          return GestureDetector(
            onTap: () {
              navigateTo(CartView(state.model));
            },
            child: Badge(
              isLabelVisible: state.model.list.isNotEmpty,
              offset: Offset(8.w, -8.h),
              padding: EdgeInsets.all(2.r),
              backgroundColor: Colors.white,
              alignment: AlignmentDirectional.topStart,
              label: CircleAvatar(
                radius: 6.r,
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  state.model.list.length.toString(),
                  style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              child: const AppBarIcon(
                path: DataAssets.iconCart,
              ),
            ),
          );
        } else if (state is CardFieldState) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
