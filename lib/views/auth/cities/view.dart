import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_string.dart';
import '../../../features/auth/cities/bloc.dart';
import '../../../features/auth/cities/model.dart';

class CitiesSheet extends StatefulWidget {
  const CitiesSheet({Key? key}) : super(key: key);

  @override
  State<CitiesSheet> createState() => _CitiesSheetState();
}

class _CitiesSheetState extends State<CitiesSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 24.h,
          ),
          Text(
            DataString.country.tr(),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          ),
          Expanded(
            child: BlocBuilder<CitiesBloc, CitiesStates>(
              builder: (context, state) {
                if (state is CitiesLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CitiesSuccessState) {
                  return ListView.builder(
                    padding: EdgeInsets.all(16.r),
                    itemBuilder: (context, index) => _Item(
                      model: state.model.list[index],
                    ),
                    itemCount: state.model.list.length,
                  );
                } else if (state is CitiesFailedState) {
                  return Center(
                    child: Text(
                      state.message.tr(),
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
          )
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final CitiesModel model;

  const _Item({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, model);
      },
      child: Container(
        padding: EdgeInsets.all(8.r),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.r),
            color: Theme.of(context).primaryColor.withOpacity(.1)),
        child: Center(
          child: Text(
            model.name.tr(),
          ),
        ),
      ),
    );
  }
}
