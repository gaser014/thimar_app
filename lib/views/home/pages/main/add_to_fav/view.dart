

import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/design/widget/app_bar_icon.dart';
import '../../../../../core/design/widget/image.dart';
import '../../../../../features/add_to_fav/bloc.dart';
import '../../../../../features/products/bloc.dart';

class DetailsImageView extends StatefulWidget {
  final ProductModel model;


  const DetailsImageView({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<DetailsImageView> createState() => _DetailsImageViewState();
}

class _DetailsImageViewState extends State<DetailsImageView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ZoomIn(
          child: SizedBox(
   child:   widget.model.images.length<=1
              ? ClipRRect(
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(20.r),
                    bottomStart: Radius.circular(20.r),
                  ),
                  child: AppImage(
                      path:  widget.model.mainImage,
                      width: double.infinity,
                      height: 322.h,
                      fit: BoxFit.fill),
                )
              : Column(
                children: [
                  CarouselSlider(
                      items: List.generate(
                        widget.model. images.length,
                        (index) => ClipRRect(
                          borderRadius: BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(20.r),
                            bottomStart: Radius.circular(20.r),
                          ),
                          child: AppImage(
                              path:  widget.model.images[index].url,
                              width: double.infinity,
                              height: 322.h,
                              fit: BoxFit.fill),
                        ),
                      ),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          FavBloc.currentIndex = index;
                          setState(() {});
                        },
                      ),
                    ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.model. images.length,
                          (index) => Padding(
                        padding:  EdgeInsetsDirectional.only(
                          end: 3.0.w,
                        ),
                        child: CircleAvatar(
                          radius: FavBloc.currentIndex == index ? 4 :3,
                          backgroundColor: FavBloc.currentIndex  == index
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),),
        ),
        SizedBox(
          height: 80,
          child: Padding(
            padding: EdgeInsetsDirectional.all(16.r),
            child: Row(
              children: [
                GestureDetector(
                  child: const AppBarIcon(),
                  onTap: () {
          Navigator.pop(context);       },
                ),
                const Spacer(),
                Builder(builder: (context) {
                  final bloc = BlocProvider.of<FavBloc>(context);
                  return BlocBuilder(
                    bloc: bloc,
                    builder: (BuildContext context, state) {
                      return GestureDetector(
                        child: widget.model.favoriteIcon,
                        onTap: () {
                          if (state is! FavLoadingState) {
                            bloc.add(
                              FavEvent(
                                product: widget.model,
                              ),
                            );
                          }
                        },
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
