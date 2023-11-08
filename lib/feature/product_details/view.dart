import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/image.dart';
import 'package:themar/core/design/widget/app_bar_icon.dart';
import 'package:themar/feature/products/bloc.dart';
import 'package:themar/feature/review/bloc.dart';
import '../../../core/design/unit/app_assets.dart';
import 'bloc.dart';

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
        body: ListView(
          children: [
            Stack(
              children: [
                widget.model.images.isEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(20.r),
                          bottomStart: Radius.circular(20.r),
                        ),
                        child: AppImage(
                            path: widget.model.mainImage,
                            width: double.infinity,
                            height: 322.h,
                            fit: BoxFit.fill),
                      )
                    : CarouselSlider(
                        items: List.generate(
                          widget.model.images.length,
                          (index) => ClipRRect(
                            borderRadius: BorderRadiusDirectional.only(
                              bottomEnd: Radius.circular(20.r),
                              bottomStart: Radius.circular(20.r),
                            ),
                            child: AppImage(
                                path: widget.model.images[index].url,
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
                          bloc.isFav = widget.model.isFavorite;
                          return BlocBuilder(
                            bloc: bloc,
                            builder: (BuildContext context, state) {
                              return GestureDetector(
                                child: AppBarIcon(
                                  path:
                                      bloc.isFav ? '' : DataAssets.iconFavorite,
                                  icon: bloc.isFav
                                      ? Icon(
                                          Icons.favorite,
                                          color: Theme.of(context).primaryColor,
                                        )
                                      : null,
                                ),
                                onTap: () {
                                  if (bloc.isFav) {
                                    bloc.add(
                                      UnFavEvent(
                                        widget.model.id,
                                      ),
                                    );
                                  } else {
                                    bloc.add(
                                      FavEvent(
                                        widget.model.id,
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
            ),
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
                        textDirection: TextDirection.ltr,
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
                            text: "${widget.model.price}ر.س",
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              const TextSpan(text: " "),
                              TextSpan(
                                text: "${widget.model.priceBeforeDiscount}ر.س",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300,
                                  decoration: TextDecoration.lineThrough,
                                ),
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
                        "${DataString.amount} ${widget.model.unit.name}",
                        style: TextStyle(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xff808080),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 110.h,
                        height: 36.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: const Color(0xff4C8613).withOpacity(.11),
                        ),
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 5.w,
                          vertical: 3.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 30.w,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            Text("1",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor,
                                )),
                            GestureDetector(
                              child: Container(
                                width: 30.w,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Center(
                                    child: Icon(
                                      Icons.remove,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
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
                      text: "${DataString.codeProduct} ",
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: " ${widget.model.id}",
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
                    DataString.description,
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
                  Text(
                    DataString.review,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  ReviewView(id: widget.model.id),
                  Text(
                    DataString.relatedProducts,
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

