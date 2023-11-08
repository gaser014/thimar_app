part of 'bloc.dart';

class ProductView extends StatefulWidget {
  final int? id;
  final bool isListScroll;
  final ProductType type;
final String? keyword;
  const ProductView({Key? key, this.isListScroll = false, this.id, this.type = ProductType.custom,this.keyword})
      : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
@override
  void initState() {
    super.initState();
    BlocProvider.of<ProductsBloc>(context).add(ProductEvent(type: widget.type,keyword: widget.keyword,id: widget.id));
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(

      builder: (context, state) {
        if (state is ProductsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductsSuccessState) {
          return widget.isListScroll
              ? ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    state.model.length,
                    (index) => (widget.id != null && widget.id == state.model[index].id)
                        ? const SizedBox()
                        : Transform.scale(
                            scale: .9,
                            child: SizedBox(
                              width: 163.w,
                              height: 250.h*1.sh/746.h,
                              child: ItemProduct(
                                model: state.model[index],
                              ),
                            ),
                          ),
                  ),
                )
              : AppGridView(
                  length: state.model.length,
                  widget: (context, index) =>  ItemProduct(
                    model: state.model[index],
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

class ItemProduct extends StatelessWidget {
  final ProductModel model;

  const ItemProduct({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 11.r,
            offset: Offset(0, 2.h*1.sh/746.h),
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
                      path: model.mainImage,
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 3.h*1.sh/746.h),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadiusDirectional.only(
                            bottomStart: Radius.circular(11.r),
                          ),
                        ),
                        child: Text(
                          "-${model.discount}%",
                          textDirection: TextDirection.ltr,
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
              model.title,
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
              "${DataString.amount} ${model.unit.name}",
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
                      text: "${model.price}ر.س",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        const TextSpan(text: " "),
                        TextSpan(
                          text: "${model.priceBeforeDiscount}ر.س",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.lineThrough,
                          ),
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
              child: GestureDetector(
                onTap: () {
                  navigateTo(ProductDetailsView(model: model));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff61B80C),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                    child: Text(
                      DataString.add,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
