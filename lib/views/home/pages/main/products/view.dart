import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/features/cart/bloc.dart';
import 'package:themar/features/products/bloc.dart';
import 'package:themar/views/home/pages/main/products/product_details/view.dart';

import '../../../../../core/design/unit/app_string.dart';
import '../../../../../core/design/widget/app_grid.dart';
import '../../../../../core/design/widget/image.dart';
import '../../../../../core/logic/get_it.dart';
import '../../../../../features/add_to_card/bloc.dart';

class ProductView extends StatefulWidget {
  final int? id;
  final bool isListScroll;
  final ProductType type;
  final String? keyword;

  const ProductView(
      {Key? key,
      this.isListScroll = false,
      this.id,
      this.type = ProductType.custom,
      this.keyword})
      : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  late final ProductsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = getIt<ProductsBloc>();
    bloc.add(
      ProductEvent(
        type: widget.type,
        keyword: widget.keyword,
        id: widget.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is ProductsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductsSuccessState) {
          return widget.isListScroll
              ? ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    state.model.length,
                    (index) => (widget.id != null &&
                            widget.id == state.model[index].id)
                        ? const SizedBox()
                        : Transform.scale(
                            scale: .9,
                            child: SizedBox(
                              width: 163.w,
                              height: 250.h * 1.sh / 746.h,
                              child: ItemProduct(
                                model: state.model[index],
                                isUpdateBadge: true,
                              ),
                            ),
                          ),
                  ),
                )
              : AppGridView(
                  length: state.model.length,
                  widget: (context, index) => ItemProduct(
                        model: state.model[index],
                        isUpdateBadge: widget.type == ProductType.custom,
                      ));
        } else if (state is ProductsFieldState) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class ItemProduct extends StatefulWidget {
  final ProductModel model;
  final bool isUpdateBadge;

  const ItemProduct({
    Key? key,
    required this.model,
    this.isUpdateBadge = false,
  }) : super(key: key);

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  late final AddToCardBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          ProductDetailsView(
            model: widget.model,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 11.r,
              offset: Offset(0, 2.h * 1.sh / 746.h),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AppImage(
                        path: widget.model.mainImage,
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 3.h * 1.sh / 746.h,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(11.r),
                            ),
                          ),
                          child: Text(
                            "${widget.model.discount}%",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              //title
              Text(
                textAlign: TextAlign.start,
                widget.model.title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              //amount
              Text(
                "${DataString.amount.tr()} ${widget.model.unit.name.tr()}",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xff808080),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              //price
              Row(
                children: [
                  //price
                  Text.rich(
                      style: TextStyle(
                        decorationColor: Theme.of(context).primaryColor,
                        color: Theme.of(context).primaryColor,
                      ),
                      TextSpan(
                        text: "${widget.model.price} ${DataString.currency.tr()} ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          const TextSpan(text: " "),
                          TextSpan(
                            text: "${widget.model.priceBeforeDiscount} ${DataString.currency.tr()}",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300,
                                decorationStyle: TextDecorationStyle.solid,
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 20),
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              //add to cart
              Center(
                child: SizedBox(
                  height: 40.h,
                  width: 120.w,
                  child: BlocConsumer(
                    listener: (context, state) {
                      if (state is AddToCardSuccessState && state.isGetCard) {
                        BlocProvider.of<CardBloc>(context).add(
                          GetCardEvent(massage: 'Hello from product view'),
                        );
                        state.isGetCard = false;

                      }
                    },
                    bloc: bloc,

                    builder: (context, state) => GestureDetector(
                      onTap: () {
                        if (state is! AddToCardLoadingState &&
                            widget.model.amount != 0) {
                          bloc.add(
                            AddToCardEvent(
                              model: widget.model,
                              isNavigateToDetails: widget.isUpdateBadge,
                              //     function:
                              //     (){ if (state is AddToCardSuccessState ) {
                              // BlocProvider.of<CardBloc>(context).add(
                              // GetCardEvent(),
                              // );
                              // print("success builder in product view");
                              // }}
                            ),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.model.amount != 0
                              ? const Color(0xff61B80C)
                              : Theme.of(context).primaryColor.withOpacity(.2),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Center(
                          child: (state is AddToCardLoadingState && widget.model.id == state.id)
                              ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: LinearProgressIndicator(),
                              )
                              : Text(
                                  DataString.add.tr(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
