import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_assets.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/app_counter.dart';
import 'package:themar/core/design/widget/image.dart';
import '../../../../../../features/add_to_card/bloc.dart';
import '../../../../../../features/products/bloc.dart';
import '../../add_to_fav/view.dart';
import '../../review/view.dart';
import '../view.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductModel model;

  const ProductDetailsView({Key? key, required this.model}) : super(key: key);

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar:widget.model.amount!=0?BottomDetails(widget.model):null,
        body: ListView(
          children: [
            DetailsImageView(model: widget.model),
            Padding(
              padding: EdgeInsetsDirectional.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      //title
                      Text(
                        textAlign: TextAlign.start,
                        widget.model.title,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const Spacer(),
                      //discount
                      Text(
                        "${widget.model.discount}%",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xffFF0000),
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      //price
                      Text.rich(
                          style: TextStyle(
                            decorationColor: Theme.of(context).primaryColor,
                            color: Theme.of(context).primaryColor,
                          ),
                          TextSpan(
                            text: "${widget.model.price} ${DataString.currency.tr()}",
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              const TextSpan(text: " "),
                              TextSpan(
                                text: "${widget.model.priceBeforeDiscount} ${DataString.currency.tr()}",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300,
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: 20),
                              ),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  //amount
                  Row(
                    children: [
                      Text(
                        "${DataString.amount.tr()} ${widget.model.unit.name}",
                        style: TextStyle(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xff808080),
                        ),
                      ),
                      const Spacer(),
                      AppCounter(
                        amount: widget.model.amount,
                        currentCount: widget.model.count,
                        decrement: () {
                          if (widget.model.count > 1) {
                            widget.model.count--;
                            widget.model.totalPrice =
                                widget.model.getTotalPrice(widget.model.count);
                            debugPrint('*' * 50);
                            debugPrint(
                                'Total Price +${widget.model.totalPrice}');
                          }
                          setState(() {});
                        },
                        increment: () {
                          if (widget.model.count < widget.model.amount) {
                            widget.model.count++;
                            widget.model.totalPrice =
                                widget.model.getTotalPrice(widget.model.count);
                            debugPrint('*' * 50);
                            debugPrint(
                                'Total Price +${widget.model.totalPrice}');
                          }
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  const Divider(
                    color: Color(0xfff9f9f9),
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  //code product
                  Text.rich(
                    TextSpan(
                      text: "${DataString.codeProduct.tr()} ",
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: " #${widget.model.id}",
                          style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xff808080),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 12.h,
                  ),
                  const Divider(
                    color: Color(0xfff9f9f9),
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  //description
                  Text(
                    DataString.description.tr(),
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    widget.model.description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xff757575),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  //review
                  ReviewView(id: widget.model.id),
                  Text(
                    DataString.relatedProducts.tr(),
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                      height: 250.h,
                      child: ProductView(
                        isListScroll: true,
                        id: widget.model.id,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BottomDetails extends StatelessWidget {
  final ProductModel model;

  const BottomDetails(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AddToCardBloc>(context);
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) => StatefulBuilder(
        builder: (context, setState) => InkWell(
          child: Container(
              height: 60.h,
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 32.0.r, vertical: 14.0.w),
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
                      "${model.totalPrice} ${DataString.currency}",
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
            if (state is! AddToCardLoadingState && model.amount != 0) {
              bloc.add(AddToCardEvent(
                model: model,
              ));
              if (state is AddToCardSuccessState) {
                // navigateTo(const HomeView());
                //todo
                // showModalBottomSheet(context: context, builder: (context)=>const B()

                // );
              }
            }
          },
        ),
      ),
    );
  }
}
