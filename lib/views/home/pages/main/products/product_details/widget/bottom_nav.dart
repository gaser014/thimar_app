part of '../view.dart';

class BottomDetails extends StatefulWidget {
  final ProductModel model;

  const BottomDetails(this.model, {Key? key}) : super(key: key);

  @override
  State<BottomDetails> createState() => _BottomDetailsState();
}

class _BottomDetailsState extends State<BottomDetails> {
  late final AddToCardBloc bloc;
  @override
  void initState() {
    bloc = getIt<AddToCardBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: bloc,
        listener: (context, state) async {
          if (state is AddToCardSuccessState) {
            final CardBloc bloc = getIt<CardBloc>();
            bloc.add(
              GetCardEvent(massage: state.message),
            );
            if (bloc.state is CardSuccessState) {
              await showModalBottomSheet(
                context: context,
                builder: (context) => BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) => state is CardSuccessState
                      ? SheetDetails(
                          model: widget.model,
                          cardData: state.model,
                        )
                      : const SizedBox(),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is AddToCardLoadingState) {
            return SizedBox(
              height: 60.h,
              child: const Center(child: LinearProgressIndicator()),
            );
          } else if (state is AddToCardFieldState) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return InkWell(
              child: Container(
                  height: 60.h,
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 32.0.r, vertical: 14.0.w),
                    child: Row(
                      children: [
                        Container(
                          height: 32.h,
                          width: 36.w,
                          decoration: BoxDecoration(
                            color: const Color(0xff61B80C),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: const AppImage(
                            path: DataAssets.iconBasket,
                            color: Colors.white,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        SizedBox(
                          width: 10.0.w,
                        ),
                        Text(
                          DataString.addToCart.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "${widget.model.totalPrice} ${DataString.currency.tr()}",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )),
              onTap: () {
                if (state is! AddToCardLoadingState &&
                    widget.model.amount != 0) {
                  bloc.add(AddToCardEvent(
                    model: widget.model,
                  ));
                  // if (state is AddToCardSuccessState) {
                  //   // navigateTo(const HomeView());
                  //   //todo
                  // }
                }
              },
            );
          }
        });
  }
}
