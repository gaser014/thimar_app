import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_assets.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/app_button.dart';
import 'package:themar/core/design/widget/app_counter.dart';
import 'package:themar/core/design/widget/app_input.dart';
import 'package:themar/core/design/widget/custom_app_bar.dart';
import 'package:themar/core/design/widget/image.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/feature/cart/bloc.dart';
import '../../core/design/widget/app_bar_icon.dart';

class CartView extends StatefulWidget {
  CardData model;

  CartView(this.model, {Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: DataString.myCart),
      bottomNavigationBar: BottomCard(model: widget.model),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0.r),
        child: ListView(
          children: [
            widget.model.list.isEmpty
                ? const SizedBox()
                : Builder(builder: (context) {
                    final bloc = BlocProvider.of<CardBloc>(context);
                    return BlocBuilder(
                        bloc: bloc,
                        builder: (context, state) => ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: List.generate(
                                widget.model.list.length,
                                (index) => CardItems(
                                  model: widget.model,
                                  index: index,
                                  onTap: () {
                                    print('*' * 50);
                                    print(widget.model.list.length);
                                    print('delete');
                                    if (state is! DeleteCardLoadingState) {
                                      bloc.add(DeleteCardEvent(
                                          model: widget.model, index: index));
                                      print(index);

                                      if (state is CardSuccessState) {
                                        widget.model = state.model;
                                        setState(() {});
                                      }
                                    }
                                  },
                                ),
                              ),
                            ));
                  }),
            SizedBox(height: 12.h),
            Container(
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 17.r,
                  ),
                ],
              ),
              child: Builder(builder: (context) {
                final bloc = BlocProvider.of<CardBloc>(context);
                return BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) => Row(
                    children: [
                      SizedBox(
                        width: .5.sw,
                        child: AppInput(
                          label: DataString.haveCoupon,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return DataString.enterCoupon;
                            }
                            return null;
                          },
                          controller: bloc.couponController,
                        ),
                      ),
                      const Spacer(),
                      state is CouponLoadingState
                          ? const Center(child: CircularProgressIndicator())
                          : Padding(
                              padding: EdgeInsets.all(8.r),
                              child: InkWell(
                                child: Container(
                                  height: 40.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      DataString.apply,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  bloc.add(SendCouponEvent());
                                },
                              )),
                    ],
                  ),
                );
              }),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0.w),
                child: Text(
                  widget.model.vipMessage ?? DataString.vipMessage,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class CartBadgeView extends StatefulWidget {
  const CartBadgeView({Key? key}) : super(key: key);

  @override
  State<CartBadgeView> createState() => _CartBadgeViewState();
}

class _CartBadgeViewState extends State<CartBadgeView> {
  @override
  void initState() {
    BlocProvider.of<CardBloc>(context).add(GetCardEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardBloc, CardState>(
      builder: (BuildContext context, CardState state) {
        if (state is CardSuccessState) {
          return GestureDetector(
            onTap: () {
              navigateTo(CartView(state.model));
            },
            child: Badge(
              isLabelVisible: state.model.list.isNotEmpty,
              offset: Offset(8.w, -8.h),
              padding: EdgeInsets.all(2.r),
              backgroundColor: Colors.white,
              alignment: AlignmentDirectional.topStart,
              label: CircleAvatar(
                radius: 6.r,
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  state.model.list.length.toString(),
                  style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              child: const AppBarIcon(
                path: DataAssets.iconCart,
              ),
            ),
          );
        } else {
          return const AppBarIcon(
            path: DataAssets.iconCart,
          );
        }
      },
    );
  }
}

class CardItems extends StatefulWidget {
  final CardData model;
  final int index;
  final void Function()? onTap;

  const CardItems({Key? key, required this.model, required this.onTap, required this.index })
      : super(key: key);

  @override
  State<CardItems> createState() => _CardItemsState();
}

class _CardItemsState extends State<CardItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        height: 98.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 17.r,
              offset: Offset(0, 6.h),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Row(
            children: [
              AppImage(
                  path: widget.model.list[widget.index].image,
                  width: 92.w,
                  height: 78.h,
                  fit: BoxFit.cover),
              SizedBox(width: 8.w),
              Column(
                children: [
                  Text.rich(
                    TextSpan(text: widget.model.list[widget.index].title, children: [
                      const TextSpan(
                        text: '\n',
                      ),
                      TextSpan(
                        text: "${widget.model.list[widget.index].price} ر.س",
                        style: TextStyle(
                          fontSize: 13.sp,
                        ),
                      ),
                    ]),
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Transform.scale(
                    scaleX: 72 / 110,
                    scaleY: 28 / 36,
                    child: Builder(
                      builder: (context) {
                        final bloc = BlocProvider.of<CardBloc>(context);
                        return BlocBuilder(
                          bloc: bloc,
                          builder:(context, state)
                              {
                                if(state is CardSuccessState) {
                                  return  AppCounter(
                                    amount: state.model.list[widget.index].remainingAmount,
                                    currentCount: state.model.list[widget.index].amount,
                                    decrement: () {
                                      if (state.model.list[widget.index].amount > 1) {

                                        if(state is ! UpDateCardLoadingState) {
                                          bloc.add(
                                            UpDateCardEvent(
                                              model: state.model,
                                              index: widget.index,
                                              isAdd: false,
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    increment: () {
                                      if (state.model.list[widget.index].amount <state.model.list[widget.index].remainingAmount ) {

                                        if(state is ! UpDateCardLoadingState) {
                                          bloc.add(
                                            UpDateCardEvent(
                                              model: widget.model,
                                              index: widget.index,
                                              isAdd: true,
                                            ),
                                          );
                                        }
                                      }

                                    },
                                  );
                                }
                                return Container();
                              },

                        );
                      }
                    ),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.red.withOpacity(.11),
                  ),
                  child: const Center(
                      child: AppImage(
                    path: DataAssets.iconDelete,
                    color: Colors.red,
                    fit: BoxFit.scaleDown,
                  )),
                ),
              ),
              SizedBox(width: 8.w),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomCard extends StatelessWidget {
  final CardData model;

  const BottomCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: .35.sh,
      padding: EdgeInsets.all(16.r),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13.r),
              color: const Color(0xffF3F8EE),
            ),
            child: Builder(builder: (context) {
              final bloc = BlocProvider.of<CardBloc>(context);
              return BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is CardSuccessState) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(9.0.r),
                            child: Row(
                              children: [
                                Text(
                                  DataString.totalPriceBeforeDiscount,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${state.model.totalPriceBeforeDiscount} ر.س',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          state.model.vatWidget,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 9.0.w),
                            child: Row(
                              children: [
                                Text(
                                  DataString.totalDiscount,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${state.model.totalDiscount * -1} ر.س',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 9.0.w),
                            child: const Divider(),
                          ),
                          Padding(
                            padding: EdgeInsets.all(9.0.r),
                            child: Row(
                              children: [
                                Text(
                                  DataString.totalCard,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${state.model.totalPriceWithVat} ر.س',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (state is DeleteCardLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is DeleteCardFieldState) {
                      return const Text('Network Error');
                    } else {
                      return const SizedBox();
                    }
                  });
            }),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              text: DataString.finishedCard,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
