part of 'bloc.dart';
class SliderView extends StatefulWidget {
  const SliderView({Key? key}) : super(key: key);

  @override
  State<SliderView> createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> {
  @override
  Widget build(BuildContext context) {
    return               BlocBuilder<SliderBloc, SliderState>(
      builder: (BuildContext context, SliderState state) {
        SliderBloc bloc = BlocProvider.of<SliderBloc>(context);

        if (state is SliderLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SliderSuccessState) {
          return Column(
            children: [
              SizedBox(
                height: 164.h*1.sh/746.h,
                width: double.infinity,
                child: CarouselSlider(
                  items: List.generate(
                    state.model.length,
                        (index) => AppImage(
                        path: state.model[index].media,
                        width: double.infinity,
                        height: 164.h*1.sh/746.h,
                        fit: BoxFit.fill),
                  ),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: 164.h*1.sh/746.h,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      bloc.index = index;
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(height: 8.h*1.sh/746.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  state.model.length,
                      (index) => Padding(
                    padding:  EdgeInsetsDirectional.only(
                      end: 3.0.w,
                    ),
                    child: CircleAvatar(
                      radius: bloc.index == index ? 7 : 6,
                      backgroundColor: bloc.index == index
                          ? const Color(0xffcadcb5)
                          : const Color(0xFFecf8e2),
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
    )
    ;
  }
}
