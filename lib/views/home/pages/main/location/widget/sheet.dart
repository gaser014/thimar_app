import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/features/location/model.dart';

import '../../../../../../core/design/unit/app_string.dart';
import 'Show_all_address.dart';

class LocationSheet extends StatefulWidget {

  const LocationSheet({super.key, });

  @override
  State<LocationSheet> createState() => _LocationSheetState();
}

class _LocationSheetState extends State<LocationSheet> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420.h,
      width: double.infinity,
      padding: EdgeInsetsDirectional.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40.r),
          topLeft: Radius.circular(40.r),
        ),
      ),
      child: Column(
        children: [
          Text(
            DataString.address.tr(),
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            height: 28.h,
          ),
          Expanded(child: ShowAllAddress()),
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 55.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffF9FCF5),
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 1.w,
              ),
            ),
            child: Center(
              child: Text(
                DataString.addNewAddress.tr(),
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 24.h,
          )
        ],
      ),
    );
  }
}
