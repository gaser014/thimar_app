part of '../../bloc.dart';
class _MyAccount extends StatelessWidget {
  const _MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: 220.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.r),
            bottomRight: Radius.circular(40.r),
          ),
          color: Theme.of(context).primaryColor,
          image: DecorationImage(
            image: AssetImage(
              DataAssets.imagesBackgroundAccount,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
