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
    final bloc = BlocProvider.of<ProductsBloc>(context);
    return SafeArea(
      child: Scaffold(
        appBar: _MainAppbar(),
        body: Center(
          child: ListView(
            children: [
              //search
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) => AppInput(
                    isFilled: true,
                    label: DataString.search,
                    image: DataAssets.iconSearch,
                    validator: (value) {
                      return null;
                    },
                    onChanged: (value) async{
                      bloc.add(ProductEvent(keyword: value));
                      setState(() {
                            });
                    },
                    controller: searchController,
                  ),
                ),
              ),
              SizedBox(height: 16.h*1.sh/746.h),

             searchController.text.isEmpty? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //slider
                  const SliderView(),
                   SizedBox(
                    height: 16.h*1.sh/746.h,
                  ),
                  //categories_title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      DataString.sections,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  //categories
                  SizedBox(width: 1.sw,child: const CategoriesView()),
                  SizedBox(
                    height: 16.h*1.sh/746.h,
                  ),


                ],
              ):const SizedBox(),
              //items_title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  DataString.items,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              //items
              ProductView(keyword: searchController.text),

              SizedBox(
                height: 16.h*1.sh/746.h,
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
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        height: 70.h*1.sh/746.h,
        child: Row(

          children: [
            AppImage(
              path: DataAssets.imagesLogo,
              width: 20.w,
              height: 20.h*1.sh/746.h,
              fit: BoxFit.scaleDown,
            ),
            SizedBox(width: 2.w),
            Text(
              DataString.cart,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
              ),
            ),

            Expanded(
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
              text: '  ${DataString.delivery}',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).primaryColor,
              ),
              children: [
                const TextSpan(text: "\n"),
                TextSpan(
                  text: '  ${DataString.cart}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
                ),
              ),
            ),
           SizedBox(width: 32.w,),
           const CartBadgeView(),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70.0.h*1.sh/746.h);
}
