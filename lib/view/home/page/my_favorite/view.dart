part of '../../bloc.dart';

class _MyFavPage extends StatelessWidget {
  const _MyFavPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _FavAppbar(),
        body: const ProductView(
          type: ProductType.favorite,
        ));
  }
}
class _FavAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 70.h,
        child:Center(
          child: Text(
              DataString.myFav,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70.0.h);
}
