import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/logic/get_it.dart';
import 'package:themar/features/location/bloc.dart';
import 'package:themar/features/location/model.dart';
import 'package:themar/views/home/pages/main/location/widget/Show_all_address.dart';
import 'package:themar/views/home/pages/main/location/widget/sheet.dart';

import '../../../../../../core/design/unit/app_string.dart';
import '../../../../../../core/logic/cashed_helper.dart';
import '../../../../../../core/logic/helper_methods.dart';
import '../view.dart';

class LocationFinishOrder extends StatefulWidget {
  const LocationFinishOrder({super.key});

  @override
  State<LocationFinishOrder> createState() => _LocationFinishOrderState();
}

class _LocationFinishOrderState extends State<LocationFinishOrder> {
  late final LocationBloc bloc;
  @override
  void initState() {
    bloc = getIt<LocationBloc>()..add(GetAddressEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: bloc,
      listener: (context, state) {
        if (state is AddressSuccessState) {
          print(state.model.first.location);
        }
      },
      builder: (context, state) {
        if (state is AddressSuccessState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${DataString.phone.tr()} : ${state.model.first.phone}",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              Row(
                children: [
                  Text(
                    DataString.chooseDeliveryAddress.tr(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    child: Container(
                        width: 28.w,
                        height: 28.h,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(.13),
                          borderRadius: BorderRadius.circular(9.r),
                          border: Border.all(
                            color: Colors.black.withOpacity(.14),
                            width: .8.w,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Theme.of(context).primaryColor,
                            size: 18.r,
                          ),
                        )),
                    onTap: () {
                      navigateTo(const MapLocationView());
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              GestureDetector(
                onTap: () async {
              LocationModel? result=    await showModalBottomSheet(
                    context: context,
                    builder: (context) => const LocationSheet(),
                  );
                  if (result != null) {
state.model.first=result;
                    setState(() {});
                  }
                },
                child: Container(
                  height: 33.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40.r),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        state.model.first.location,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Theme.of(context).primaryColor,
                        size: 18.r,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        if (state is AddressLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is AddressFieldsState) {
          return Text(state.massage);
        }
        return const SizedBox();
      },
    );
  }
}
