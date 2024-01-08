import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/logic/helper_methods.dart';
import '../../../../../../core/design/unit/app_string.dart';
import '../../../../../../core/design/widget/app_button.dart';
import '../../../../../../core/logic/get_it.dart';
import '../../../../../../features/cart/bloc.dart';
import '../../../../../../features/cart/model.dart';
import '../finish_order/view.dart';

//ignore: must_be_immutable
class BottomCard extends StatefulWidget {
  CardData model;
  final void Function() navigateTo;
  final String text;

  BottomCard({
    Key? key,
    required this.model,
    required this.navigateTo,
    this.text = DataString.finishedCard,
  }) : super(key: key);

  @override
  State<BottomCard> createState() => _BottomCardState();
}

class _BottomCardState extends State<BottomCard> {
  late final CardBloc bloc;

  @override
  void initState() {
    bloc = getIt<CardBloc>();
    super.initState();
  }

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
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.r),
                color: const Color(0xffF3F8EE),
              ),
              child: BlocConsumer(
                listener: (context, state) {
                  if (state is CardSuccessState) {
                    widget.model = state.model;
                  }
                },
                bloc: bloc,
                builder: (context, state) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(9.0.r),
                      child: Row(
                        children: [
                          Text(
                            DataString.totalPriceBeforeDiscount.tr(),
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${widget.model.totalPriceBeforeDiscount.toStringAsFixed(2)}  ${DataString.currency.tr()}',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    widget.model.vatWidget,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9.0.w),
                      child: Row(
                        children: [
                          Text(
                            DataString.totalDiscount.tr(),
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '- ${widget.model.totalDiscount.toStringAsFixed(2)}  ${DataString.currency.tr()}',
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
                            DataString.totalCard.tr(),
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${widget.model.totalPriceWithVat.toStringAsFixed(2)}  ${DataString.currency.tr()}',
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
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          if(widget.text == DataString.finishedCard)
          SizedBox(
            width: double.infinity,
            child: AppButton(
              text: widget.text.tr(),
              onPressed: () {
                navigateTo(FinishOrderView(
                  model: widget.model,
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
