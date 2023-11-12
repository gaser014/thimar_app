
part of 'bloc.dart';

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
     widget.model.images.isEmpty
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
            : CarouselSlider(
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
                  height: 164.h,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    FavBloc.currentIndex = index;
                    setState(() {});
                  },
                ),
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
                    Navigator.pop(context);
                  },
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
