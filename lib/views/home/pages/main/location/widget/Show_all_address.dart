import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../core/design/unit/app_assets.dart';
import '../../../../../../core/design/unit/app_string.dart';
import '../../../../../../core/design/widget/app_image.dart';
import '../../../../../../core/logic/get_it.dart';
import '../../../../../../features/location/bloc.dart';

class ShowAllAddress extends StatefulWidget {
  const ShowAllAddress({super.key});

  @override
  State<ShowAllAddress> createState() => _ShowAllAddressState();
}

class _ShowAllAddressState extends State<ShowAllAddress> {
  late final LocationBloc bloc;

  @override
  void initState() {
    bloc = getIt<LocationBloc>();
    bloc.add(GetAddressEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (context, state) {},
      bloc: bloc,
      builder: (context, state) {
        if (state is AddressLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AddressSuccessState) {
          return ListView(
              children: List.generate(
            state.model.length,
            (index) => GestureDetector(
              onTap: () {
                Navigator.pop(context, state.model[index]);
              },
              child: Container(
                margin: EdgeInsetsDirectional.only(
                  bottom: 20.h,
                ),
                width: double.infinity,
                padding: EdgeInsetsDirectional.only(
                  start: 16.r,
                  top: 9.h,
                  end: 13.r,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 1.w,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.model[index].type,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            bloc.add(
                                DeleteAddressEvent(id: state.model[index].id));
                          },
                          child: Container(
                            width: 24.w,
                            height: 24.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffFFD4D4),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: const AppImage(
                              path: DataAssets.iconDelete,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 9.w,
                        ),
                        Container(
                          width: 24.w,
                          height: 24.h,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(.13),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: AppImage(
                            path: DataAssets.edit2,
                            color: Theme.of(context).primaryColor,
                            fit: BoxFit.scaleDown,
                          ),
                        )
                      ],
                    ),
                    Text(
                      "${DataString.addressTitle.tr()} : ${state.model[index].location}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      "${DataString.descriptionAddress.tr()} : ${state.model[index].description}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xff999797),
                      ),
                    ),
                    Text(
                      "${DataString.phone.tr()} : ${state.model[index].phone}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xff999797),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
        } else if (state is AddressFieldsState) {
          return Center(
            child: Text(
              state.massage,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
