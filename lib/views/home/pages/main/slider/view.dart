import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/design/widget/app_image.dart';
import '../../../../../features/slider/bloc.dart';

class SliderView extends StatefulWidget {
  const SliderView({Key? key}) : super(key: key);

  @override
  State<SliderView> createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderBloc, SliderStates>(
      builder: (BuildContext context, SliderStates state) {
        SliderBloc bloc = BlocProvider.of<SliderBloc>(context);
        if (state is SliderLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SliderSuccessState) {
          return Column(
            children: [
              SizedBox(
                height: 164.h * 1.sh / 746.h,
                width: double.infinity,
                child: CarouselSlider(
                  items: List.generate(
                    state.model.length,
                    (index) => AppImage(
                        path: state.model[index].media,
                        width: double.infinity,
                        height: 164.h * 1.sh / 746.h,
                        fit: BoxFit.fill),
                  ),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      bloc.index = index;
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(height: 8.h * 1.sh / 746.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  state.model.length,
                  (index) => Padding(
                    padding: EdgeInsetsDirectional.only(
                      end: 3.0.w,
                    ),
                    child: CircleAvatar(
                      radius: bloc.index == index ? 4 : 3,
                      backgroundColor: bloc.index == index
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is SliderFieldState) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
