import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/logic/helper_methods.dart';
import '../../../../../features/categories/bloc.dart';
import 'categories_details/view.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: BlocBuilder<CategoriesBloc, CategoriesStates>(
        builder: (BuildContext context, CategoriesStates state) {
          if (state is CategoriesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoriesSuccessState) {
            return SizedBox(
              height: 100.h * 1.sh / 746.h,
              width: 74.w,
              child: ListView.separated(
                itemCount: state.model.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  debugPrint(state.model[index].name);
                  debugPrint(state.model.length.toString());
                  return _ItemCategories(
                    model: state.model[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 16.w,
                  );
                },
              ),
            );
          } else if (state is CategoriesFieldState) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class _ItemCategories extends StatelessWidget {
  final CategoriesModel model;

  const _ItemCategories({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            width: 75.w,
            height: 73.h * 1.sh / 746.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9.r),
              image: DecorationImage(
                image: NetworkImage(model.image),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                    HSVColor.fromColor(Theme.of(context).primaryColor)
                        .withHue(model.id * 20.0 % 360.0)
                        .toColor()
                        .withOpacity(.2),
                    BlendMode.srcOver),
              ),
            ),
            padding: EdgeInsets.all(6.r),
          ),
          SizedBox(height: 4.h),
          Text(
            model.name,
            style: TextStyle(
              fontSize: 16.sp,
              color: const Color(0xff3E3E3E),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
      onTap: () {
        navigateTo(CategoriesDetailsView(
          id: model.id,
          name: model.name,
        ));
      },
    );
  }
}
