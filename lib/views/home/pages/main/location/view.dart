import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/app_input.dart';
import 'package:themar/views/auth/phone_input/view.dart';
import 'package:themar/views/home/pages/main/location/widget/app_map.dart';

import '../../../../../core/design/widget/custom_app_bar.dart';
import '../../../../../core/logic/get_it.dart';
import '../../../../../features/location/bloc.dart';

class MapLocationView extends StatefulWidget {
  const MapLocationView({super.key});

  @override
  State<MapLocationView> createState() => _MapLocationViewState();
}

class _MapLocationViewState extends State<MapLocationView> {
  late final LocationBloc bloc;
  late bool isDefaultAddress = false;
  bool isHome = true;
  final phoneController = TextEditingController();
  final describeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final addBloc = getIt<LocationBloc>();

  @override
  void initState() {
    bloc = getIt<LocationBloc>();
    bloc.add(GetCurrentLocationEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: DataString.addAddress.tr(),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          if (_formKey.currentState?.validate() == true) {
            List<Placemark> placeMarks = await placemarkFromCoordinates(
                bloc.marker.position.latitude, bloc.marker.position.longitude);

            addBloc.add(
              AddAddressEvent(
                location: placeMarks.first.locality.toString(),
                phone: phoneController.text,
                type: isHome ? DataString.homeAddress : DataString.workAddress,
                description: describeController.text,
                isDefault: isDefaultAddress,
              ),
            );
          }
        },
        child: Container(
          height: 54.h,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff61B80C).withOpacity(.19),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          margin: EdgeInsetsDirectional.symmetric(
            vertical: 14.h,
            horizontal: 16.w,
          ),
          padding: EdgeInsetsDirectional.only(
            start: 16.w,
            end: 13.w,
          ),
          alignment: AlignmentDirectional.center,
          child: Text(
            DataString.addAddress.tr(),
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: BlocConsumer(
        bloc: bloc,
        listener: (context, state) async {
          if (state is CurrentLocationSuccessState) {
            bloc.marker = Marker(
              //change marker icon to image from asset
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen,
              ),

              markerId: const MarkerId('location'),
              position: LatLng(
                state.position.latitude,
                state.position.longitude,
              ),
            );
          }

        },
        builder: (context, state) {
          if (state is CurrentLocationLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CurrentLocationSuccessState) {
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 16.w,
                ),
                children: [
                  AppMap(),
                  Container(
                    height: 54.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 17,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    margin: EdgeInsetsDirectional.symmetric(
                      vertical: 14.h,
                    ),
                    padding: EdgeInsetsDirectional.only(
                      start: 16.w,
                      end: 13.w,
                    ),
                    child: Row(
                      children: [
                        Text(
                          DataString.addressType.tr(),
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color(0xff8B8B8B),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isHome = true;
                            });
                          },
                          child: Container(
                            height: 36.h,
                            width: 75.w,
                            decoration: BoxDecoration(
                              color: isHome
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(11.r),
                              border: Border.all(
                                color: isHome
                                    ? Theme.of(context).primaryColor
                                    : const Color(0xffE9E9E9),
                                width: 1,
                              ),
                            ),
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              DataString.homeAddress.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: isHome
                                    ? Colors.white
                                    : const Color(0xff8B8B8B),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isHome = false;
                            });
                          },
                          child: Container(
                            height: 36.h,
                            width: 75.w,
                            decoration: BoxDecoration(
                              color: isHome
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(11.r),
                              border: Border.all(
                                color: isHome
                                    ? const Color(0xffE9E9E9)
                                    : Theme.of(context).primaryColor,
                                width: 1,
                              ),
                            ),
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              DataString.workAddress.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: isHome
                                    ? const Color(0xff8B8B8B)
                                    : Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 54.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13.r),
                    ),
                    padding: EdgeInsetsDirectional.only(
                      start: 16.w,
                      end: 13.w,
                    ),
                    child: PhoneInput(
                      phoneController: phoneController,
                      hint: DataString.enterPhone.tr(),
                    ),
                  ),
                  Container(
                    height: 54.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13.r),
                    ),
                    margin: EdgeInsetsDirectional.symmetric(
                      vertical: 14.h,
                    ),
                    padding: EdgeInsetsDirectional.only(
                      start: 16.w,
                      end: 13.w,
                    ),
                    child: AppInput(
                        controller: describeController,
                        label: DataString.descriptionAddress.tr(),
                        validator: (String? value) {
                          return null;
                        }),
                  ),
                  Container(
                    height: 54.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13.r),
                    ),
                    padding: EdgeInsetsDirectional.only(
                      start: 16.w,
                      end: 13.w,
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                            value: isDefaultAddress,
                            onChanged: (bool? value) {
                              setState(() {
                                isDefaultAddress = value!;
                              });
                            },
                            activeColor: Theme.of(context).primaryColor,
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.all(
                                isDefaultAddress
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey.withOpacity(.8)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            )),
                        Text(
                          DataString.setAsMainAddress.tr(),
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CurrentLocationFieldsState) {
            return Center(
              child: Text(
                state.massage,
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
