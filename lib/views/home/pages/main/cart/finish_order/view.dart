import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/app_button.dart';
import 'package:themar/core/design/widget/custom_app_bar.dart';
import 'package:themar/features/cart/model.dart';
import 'package:themar/views/home/pages/main/cart/widget/bottom_card.dart';

import '../../../../../../core/design/unit/app_assets.dart';
import '../../../../../../core/design/widget/app_image.dart';
import '../../../../../../core/logic/cashed_helper.dart';
import '../../../../../../core/logic/helper_methods.dart';
import '../../location/widget/finish_order_location.dart';

class FinishOrderView extends StatefulWidget {
  final CardData model;

  const FinishOrderView({super.key, required this.model});

  @override
  State<FinishOrderView> createState() => _FinishOrderViewState();
}

class _FinishOrderViewState extends State<FinishOrderView> {
  PaymentType paymentType = PaymentType.cash;
  TimeOfDay? timeOfDay;
  DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: DataString.finishCard.tr(),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppButton(
            text: DataString.finishOrder.tr(),
            onPressed: () {
              navigateTo(FinishOrderView(
                model: widget.model,
              ),);
            },
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: ListView(
          children: [
            Text(
              "${DataString.name.tr()} : ${CachedHelper.getFullName()}",
              style: TextStyle(
                color: Theme
                    .of(context)
                    .primaryColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            LocationFinishOrder(),
            SizedBox(
              height: 32.h,
            ),
            Text(
              DataString.chooseDeliveryTime.tr(),
              style: TextStyle(
                color: Theme
                    .of(context)
                    .primaryColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [

                GestureDetector(
                  onTap: () async {
                    dateTime=await      showDatePicker(context: context,
                    builder: (context,child){
                    return Theme(
                      data: ThemeData.light().copyWith(

                        colorScheme: ColorScheme.light(
                          primary: Theme.of(context).primaryColor,
                          onPrimary: Colors.white,
                          surface: Theme.of(context).primaryColor,
                          onSurface: Colors.black,
                        ),
                        dialogBackgroundColor: Colors.white,
                      ),
                      child: Transform.scale(child: child!,scale: .85),
                    );
                  },

                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.utc(DateTime
                        .now()
                        .year + 1),);
                },
                  child: Container(
                    width: .5.sw - 24.w,
                    height: 60.h,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        color: const Color(0xffF3F3F3),
                        width: 1.w,
                      ),
                    ),
                    margin: EdgeInsetsDirectional.only(end: 16.w),
                    child: Row(
                      children: [
                        Text(
                          DataString.chooseDayAndDate.tr(),
                          style: TextStyle(
                            color: Theme
                                .of(context)
                                .primaryColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        AppImage(
                          path: DataAssets.calendar,
                          width: 20.w,
                          height: 20.h,
                          fit: BoxFit.scaleDown,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    timeOfDay = await showTimePicker(
                        context: context,

                        initialTime: TimeOfDay.now());
                    setState(() {

                    });
                  },
                  child: Container(
                    width: .5.sw - 24.w,
                    height: 60.h,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        color: const Color(0xffF3F3F3),
                        width: 1.w,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              timeOfDay != null
                                  ? '${timeOfDay!.format(context,)}'
                                  : DataString.chooseTime.tr(),
                              style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                fontSize:        timeOfDay != null
                                    ?24.sp:16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                         SizedBox(width: 16.w),
                        AppImage(
                          path: DataAssets.calendarTimer,
                          width: 20.w,
                          height: 20.h,
                          fit: BoxFit.scaleDown,
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            Text(
              DataString.notesAndInstructions.tr(),
              style: TextStyle(
                color: Theme
                    .of(context)
                    .primaryColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            TextFormField(
              maxLines: 7,
              minLines: 3,
              style: TextStyle(
                fontSize: 14.sp,
              ),
              decoration: const InputDecoration(),
            ),
            SizedBox(
              height: 24.h,
            ),
            Text(
              DataString.choosePaymentMethod.tr(),
              style: TextStyle(
                color: Theme
                    .of(context)
                    .primaryColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      paymentType = PaymentType.cash;
                    });
                  },
                  child: Container(
                    width: 1.sw / 3 - 24.w,
                    height: 50.h,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        color: PaymentType.cash == paymentType
                            ? Theme
                            .of(context)
                            .primaryColor
                            : const Color(0xffF3F3F3),
                        width: 1.w,
                      ),
                    ),
                    child: Row(
                      children: [
                        AppImage(
                          path: DataAssets.cash,
                          width: 40.w,
                          height: 24.h,
                          fit: BoxFit.scaleDown,
                          color: PaymentType.cash == paymentType
                              ? Theme
                              .of(context)
                              .primaryColor
                              : const Color(0xffC2C2C2),
                        ),
                        const Spacer(),
                        Text(
                          DataString.cash.tr(),
                          style: TextStyle(
                            color: PaymentType.cash == paymentType
                                ? Theme
                                .of(context)
                                .primaryColor
                                : const Color(0xffC2C2C2),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      paymentType = PaymentType.visa;
                    });
                  },
                  child: Container(
                    width: 1.sw / 3 - 24.w,
                    height: 50.h,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        color: PaymentType.visa == paymentType
                            ? Theme
                            .of(context)
                            .primaryColor
                            : const Color(0xffF3F3F3),
                        width: 1.w,
                      ),
                    ),
                    child: AppImage(
                      path: DataAssets.visa,
                      color: PaymentType.visa == paymentType
                          ? Theme
                          .of(context)
                          .primaryColor
                          : const Color(0xffC2C2C2),
                      width: 20.w,
                      height: 20.h,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      paymentType = PaymentType.mastercard;
                    });
                  },
                  child: Container(
                    width: 1.sw / 3 - 24.w,
                    height: 50.h,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        color: PaymentType.mastercard == paymentType
                            ? Theme
                            .of(context)
                            .primaryColor
                            : const Color(0xffF3F3F3),
                        width: 1.w,
                      ),
                    ),
                    child: AppImage(
                      path: DataAssets.mastercard,
                      width: 20.w,
                      height: 20.h,
                      fit: BoxFit.scaleDown,
                      color: PaymentType.mastercard == paymentType
                          ? Theme
                          .of(context)
                          .primaryColor
                          : const Color(0xffC2C2C2),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              DataString.orderSummary.tr(),
              style: TextStyle(
                color: Theme
                    .of(context)
                    .primaryColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 200.h,
              child: BottomCard(
                model: widget.model,
                text: DataString.totalPriceBeforeDiscount.tr(),
                navigateTo: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
