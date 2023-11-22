
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/logic/get_it.dart';
import 'package:themar/features/cart/model.dart';
import 'package:themar/views/home/pages/main/cart/widget/card_items.dart';
import '../../../../../core/design/unit/app_string.dart';
import '../../../../../core/design/widget/app_input.dart';
import '../../../../../core/design/widget/custom_app_bar.dart';
import '../../../../../features/cart/bloc.dart';
import 'widget/bottom_card.dart';

class CartView extends StatefulWidget {
  final CardData model;
  const CartView({Key? key,required this.model}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late final CardBloc bloc;

  @override
  void initState() {
    bloc = getIt<CardBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  CustomAppBar(title: DataString.myCart),
      bottomNavigationBar: BottomCard( model: widget.model,),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0.r),
        child:   ListView(
          children: [
            CardItems( model: widget.model,),
            SizedBox(height: 12.h),
            Container(
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 17.r,
                  ),
                ],
              ),
              child: BlocBuilder(
                bloc: bloc,
                builder: (context, state) => Row(
                  children: [
                    SizedBox(
                      width: .5.sw,
                      child: AppInput(
                        label: DataString.haveCoupon,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return DataString.enterCoupon;
                          }
                          return null;
                        },
                        controller: bloc.couponController,
                      ),
                    ),
                    const Spacer(),
                    state is CouponLoadingState
                        ? const Center(
                        child: CircularProgressIndicator())
                        : Padding(
                        padding: EdgeInsets.all(8.r),
                        child: InkWell(
                          child: Container(
                            height: 40.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(10.r),
                              color:
                              Theme.of(context).primaryColor,
                            ),
                            child: Center(
                              child: Text(
                                DataString.apply.tr(),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            bloc.add(SendCouponEvent());
                          },
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0.w),
                child: Text(
                  widget.model.vipMessage,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        )


      ),
    );

  }
}
