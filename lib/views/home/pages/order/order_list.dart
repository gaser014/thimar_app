import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_string.dart';

import 'model.dart';

class OrderList extends StatelessWidget {
  final OrderModel model;
  const OrderList({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int price = 0;
    for (var item in model.items) {
      price += item.price;
    }
    return Center(
      child: Padding(
        padding:  EdgeInsets.only(top: 16.0.h),
        child: Container(
          height: 100.h,
          padding:  EdgeInsets.all(8.r),
          // margin: const EdgeInsets.only(bottom: 9),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:  BorderRadius.all(Radius.circular(16.r)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xfF000000).withOpacity(.02),
                blurRadius: 17,
                offset:  Offset(0, 6.h),
              ),
            ],
          ),
          child: Row(
            children: [
               SizedBox(
                width: 6.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${DataString.order} #${model.id}'.tr(),
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    model.date.tr(),
                    style:  TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xff9C9C9C),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      SizedBox(
                        width: 92.w,
                        height: 25.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 3.w),
                            child: Container(
                              width: 25.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                borderRadius:
                                     BorderRadius.all(Radius.circular(8.r)),
                                border: Border.all(
                                  color:
                                      const Color(0xff61B80C).withOpacity(.06),
                                  width: .5.w,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    model.items[index].image,
                                  ),
                                  fit: BoxFit.scaleDown,
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          itemCount:
                              model.items.length < 3 ? model.items.length : 3,
                        ),
                      ),
                       SizedBox(
                        width: 4.w,
                      ),
                      model.items.length <= 3
                          ? const SizedBox()
                          : Container(
                              width: 25.w,
                              height: 25.h,
                              alignment: Alignment.center,
                              decoration:  BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.r)),
                                color: const Color(0xffEDF5E6),
                              ),
                              child: Text(
                                '+${model.items.length - 3}'.tr(),
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )),
                    ],
                  ),
                   SizedBox(
                    height: 6.h,
                  )
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Container(
                    width: 95.w,
                    height: 26.h,
                    decoration: BoxDecoration(
                      color: Color(model.state.background).withOpacity(.2),
                      borderRadius:  BorderRadius.all(Radius.circular(8.r)),
                    ),
                    child: Center(
                      child: Text(
                        model.state.state.tr(),
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(model.state.fontColor),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$price ${DataString.currency.tr()}',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                   SizedBox(
                    height: 6.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
