
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/design/unit/app_string.dart';
import '../../../../../core/design/widget/image.dart';
import '../../../../../core/logic/get_it.dart';
import '../../../../../features/review/bloc.dart';

class ReviewView extends StatefulWidget {
  final int id;

  const ReviewView({Key? key, required this.id}) : super(key: key);

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
 late final ReviewsBloc bloc ;
  @override
  void initState() {
    bloc = getIt<ReviewsBloc>();

    bloc.add(ReviewEvent(id: widget.id));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (BuildContext context, ReviewStates state) {
        if (state is ReviewLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ReviewSuccessState) {
          return state.model.isEmpty?        Padding(
            padding:  EdgeInsets.symmetric(vertical: 16.0.h),
            child: Text(
             DataString.noReview.tr(),
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ): Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DataString.review.tr(),
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 110.h,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(state.model.length, (index) => _Review(model: state.model[index],))),
              ),
            ],
          );
        } else if (state is ReviewFieldState) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class _Review extends StatelessWidget {
 final ReviewModel model;
  const _Review({Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(
        horizontal: 24.w,
        vertical: 12.h,
      ),
      width: 280,
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 12.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 14.r,
            offset: Offset(0, 3.h),
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 110.w,
                    child: Text(
                      model.clientName,
                      style:
                          TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  RatingBarIndicator(
                    itemSize: 14.sp,
                    direction: Axis.horizontal,
                    rating: model.value,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
                    itemBuilder: (context, index) => Icon(
                      index >= model.value ? Icons.star_outline : Icons.star_outlined,
                      color: const Color(0xffFF9529),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 42.h,
                width: 180.w,
                child: Text(model.comment,
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: AppImage(
                height: 56.h,
                width: 56.w,
                path: model.clientImage,
                fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
