import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/design/unit/app_assets.dart';
import '../../../../../../core/design/unit/app_string.dart';
import '../../../../../../core/design/widget/app_counter.dart';
import '../../../../../../core/design/widget/image.dart';
import '../../../../../../core/logic/get_it.dart';
import '../../../../../../features/cart/bloc.dart';
import '../../../../../../features/cart/model.dart';

class CardItems extends StatefulWidget {
  CardData model;

  CardItems({
    required this.model,
    super.key,
  });

  @override
  State<CardItems> createState() => _CardItemsState();
}

class _CardItemsState extends State<CardItems> {
  late final CardBloc bloc;

  @override
  void initState() {
    bloc = getIt<CardBloc>();

    bloc.add(GetCardEvent(massage: 'Hello from cart CardItems'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        listener: (context, state) {
          if (state is CardSuccessState) {
            widget.model = state.model;
          }
        },
        bloc: bloc,
        builder: (context, state) {
          return ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                widget.model.list.length,
                (index) => CardItem(
                  model: widget.model,
                  index: index,
                ),
              ));
        });
  }
}

class CardItem extends StatefulWidget {
  final CardData model;
  final int index;

  const CardItem({Key? key, required this.model, required this.index})
      : super(key: key);

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  late final CardBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of(context);
    super.initState();
  }

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
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: AppImage(
                    path: widget.model.list[widget.index].image,
                    width: 92.w,
                    height: 78.h,
                    fit: BoxFit.cover),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                        text: widget.model.list[widget.index].title,
                        children: [
                          const TextSpan(
                            text: '\n',
                          ),
                          TextSpan(
                            text:
                                "${widget.model.list[widget.index].totalPriceWithVat.toStringAsFixed(2)}  ${DataString.currency.tr()}",
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
                    alignment: AlignmentDirectional.centerStart,
                    child: BlocBuilder(
                      bloc: bloc,
                      builder: (context, state) {
                        return AppCounter(
                          amount:
                              widget.model.list[widget.index].remainingAmount,
                          currentCount: widget.model.list[widget.index].amount,
                          decrement: () {
                            if (widget.model.list[widget.index].amount > 1) {
                              if (state is! UpDateCardLoadingState) {
                                bloc.add(
                                  UpDateCardEvent(
                                    model: widget.model,
                                    index: widget.index,
                                    addAmount: -1,
                                  ),
                                );
                              }
                            }
                          },
                          increment: () {
                            if (widget.model.list[widget.index].amount <
                                widget
                                    .model.list[widget.index].remainingAmount) {
                              if (state is! UpDateCardLoadingState) {
                                bloc.add(
                                  UpDateCardEvent(
                                    model: widget.model,
                                    index: widget.index,
                                    addAmount: 1,
                                  ),
                                );
                              }
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              BlocBuilder(
                bloc: bloc,
                builder: (context, state) => GestureDetector(
                  onTap: () {
                    if (state is! DeleteCardLoadingState) {
                      bloc.add(
                        DeleteCardEvent(
                          model: widget.model,
                          index: widget.index,
                        ),
                      );
                    }
                  },
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
              ),
              SizedBox(width: 8.w),
            ],
          ),
        ),
      ),
    );
  }
}
