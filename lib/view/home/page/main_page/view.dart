part of '../../bloc.dart';

class _MainPage extends StatefulWidget {
  const _MainPage({Key? key}) : super(key: key);

  @override
  State<_MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<_MainPage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _MainAppbar(),
        body: Center(
          child: ListView(
            children: [
              //search
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AppInput(
                  isFilled: true,
                  label: DataString.search,
                  image: DataAssets.iconSearch,
                  validator: (value) {
                    return null;
                  },
                  controller: searchController,
                ),
              ),
              const SizedBox(height: 16),
              //slider
              BlocBuilder<SliderBloc, SliderState>(
                builder: (BuildContext context, SliderState state) {
                  SliderBloc bloc = BlocProvider.of<SliderBloc>(context);

                  if (state is SliderLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SliderSuccessState) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 164,
                          width: double.infinity,
                          child: CarouselSlider(
                            items: List.generate(
                              state.model.length,
                              (index) => AppImage(
                                  path: state.model[index].media,
                                  width: double.infinity,
                                  height: 164,
                                  fit: BoxFit.fill),
                            ),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 164,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                bloc.index = index;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            state.model.length,
                            (index) => Padding(
                              padding: const EdgeInsetsDirectional.only(
                                end: 3.0,
                              ),
                              child: CircleAvatar(
                                radius: bloc.index == index ? 7 : 6,
                                backgroundColor: bloc.index == index
                                    ? const Color(0xffcadcb5)
                                    : const Color(0xFFecf8e2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is SliderFieldState) {
                    return Center(child: Text(state.message));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              //categories_title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    //categories
                    Text(
                      DataString.sections,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    //view all
                  ],
                ),
              ),
              //categories
              Padding(
                padding: const EdgeInsets.all(16),
                child: BlocBuilder<CategoriesBloc, CategoriesState>(
                    builder: (BuildContext context, CategoriesState state) {
                  if (state is CategoriesLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CategoriesSuccessState) {
                    return SizedBox(
                      height: 100,
                      child: ListView.separated(
                        itemCount: state.model.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => _ItemCategories(
                          model: state.model[index],
                        ),
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 16,
                          );
                        },
                      ),
                    );
                  } else if (state is CategoriesFieldState) {
                    return Center(child: Text(state.message));
                  } else {
                    return const SizedBox();
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<ProductsBloc, ProductsState>(
                    builder: (context, state) {
                  if (state is ProductsLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductsSuccessState) {
                    return GridView.builder(
                      itemCount: state.model.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 163 / 250,
                      ),
                      itemBuilder: (context, index) => _ItemProduct(
                        model: state.model[index],
                      ),
                    );
                  } else if (state is ProductsFieldState) {
                    return Center(child: Text(state.message));
                  } else {
                    return const SizedBox();
                  }
                }),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 70,
        child: Row(
          children: [
            const AppImage(
              path: DataAssets.imagesLogo,
              width: 20,
              height: 20,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(width: 2),
            const Text(
              DataString.cart,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            Expanded(
                child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: '  ${DataString.delivery}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).primaryColor,
                ),
                children: const [
                  TextSpan(text: "\n"),
                  TextSpan(
                    text: '  ${DataString.cart}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )),
            Badge(
              alignment: AlignmentDirectional.topStart,
              label: CircleAvatar(
                radius: 6,
                backgroundColor: Theme.of(context).primaryColor,
                child: const Text(
                  '3',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              offset: const Offset(8, -8),
              padding: const EdgeInsets.all(2),
              backgroundColor: Colors.white,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xff4C8613).withAlpha(13),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const AppImage(
                  path: DataAssets.iconCart,
                  width: 20,
                  height: 20,
                  fit: BoxFit.scaleDown,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70.0);
}

class _ItemCategories extends StatelessWidget {
  final CategoriesModel model;

  const _ItemCategories({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xff4C8613).withAlpha(13),
              borderRadius: BorderRadius.circular(9),
            ),
            padding: const EdgeInsets.all(6),
            child: AppImage(
              path: model.image,
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            model.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class _ItemProduct extends StatelessWidget {
  final ProductModel model;

  const _ItemProduct({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 11,
            offset: const Offset(0, 2),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadiusDirectional.only(
                            bottomStart: Radius.circular(11),
                          ),
                        ),
                        child: Text(
                          "-${model.discount}%",
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            fontSize: 14,
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
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            //amount
            Text(
              "${DataString.amount} ${model.unit.name}",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Color(0xff808080),
              ),
            ),
            const SizedBox(
              height: 3,
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
                      text:
                          "${(model.price.toString().length >= 5 && model.price is double) ? model.price.toInt() : model.price}ر.س",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        const TextSpan(text: " "),
                        TextSpan(
                          text: "${model.priceBeforeDiscount}ر.س",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    )),
                const Spacer(),
                //add to cart
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Color(0xff61B80C),
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff4C8613).withOpacity(0.1),
                              offset: const Offset(0, 3),
                            )
                          ]),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            //add to cart
            Center(
                child: SizedBox(
              height: 40,
              width: 120,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff61B80C),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                    child: Text(
                      DataString.add,
                      style: const TextStyle(
                        fontSize: 14,
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
