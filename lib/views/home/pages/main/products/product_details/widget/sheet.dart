part of '../view.dart';

class SheetDetails extends StatefulWidget {
  final ProductModel model;
  final CardData cardData;

  const SheetDetails({super.key, required this.model, required this.cardData});

  @override
  State<SheetDetails> createState() => _SheetDetailsState();
}

class _SheetDetailsState extends State<SheetDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225.h,
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40.r),
          topLeft: Radius.circular(40.r),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Container(
                  height: 18.h,
                  width: 18.w,
                  decoration: BoxDecoration(
                    color: const Color(0xffE3E8DF),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check,
                      color: Theme.of(context).primaryColor,
                      size: 15,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  DataString.productAdded.tr(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Divider(
            color: const Color(0xffEFEFEF),
            thickness: .3.sp,
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: AppImage(
                  path: widget.model.mainImage,
                  height: 64.h,
                  width: 64.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "${DataString.quantity.tr()} : ${widget.model.count}",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xff808080),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "${widget.model.totalPrice} ${DataString.currency.tr()}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Divider(
            color: const Color(0xffEFEFEF),
            thickness: .3.sp,
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                child: Container(
                  width: .5.sw - 28.sp,
                  height: 50.h,
                  margin: EdgeInsetsDirectional.only(
                    end: 8.w,
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff61B80C).withOpacity(.19),

                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  child: Center(
                    child: Text(
                      DataString.moveToCart.tr(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  navigateTo(CardView(
                    model: widget.cardData,
                  ));
                },
              ),
              GestureDetector(
                child: Container(
                  width: .5.sw - 28.sp,
                  height: 50.h,
                  margin: EdgeInsetsDirectional.only(
                    start: 8.w,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: Theme.of(context).primaryColor),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff61B80C).withOpacity(.19),

                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  child: Center(
                    child: Text(
                      DataString.browseOffers.tr(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  navigateTo(const HomeView());
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
