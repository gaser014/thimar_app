import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/design/unit/app_assets.dart';
import '../../../../../../core/design/widget/app_bar_icon.dart';
import '../../../../../../core/logic/get_it.dart';
import '../../../../../../core/logic/helper_methods.dart';
import '../../../../../../features/cart/bloc.dart';
import '../view.dart';

class CartBadgeView extends StatefulWidget {
  const CartBadgeView({Key? key}) : super(key: key);

  @override
  State<CartBadgeView> createState() => _CartBadgeViewState();
}

class _CartBadgeViewState extends State<CartBadgeView> {
  late final CardBloc bloc;
  @override
  void initState() {
    bloc = getIt<CardBloc>();
    bloc.add(GetCardEvent(massage: 'Hello from cart badge'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (BuildContext context, CardStates state) {
        if (state is CardSuccessState) {
          return GestureDetector(
            onTap: () {
              if (state.model.list.isNotEmpty) {
                navigateTo(CardView(
                  model: state.model,
                ));
              }
            },
            child: Transform.flip(
              flipX: context.locale == const Locale('en', 'US'),
              child: Badge(
                isLabelVisible: state.model.list.isNotEmpty,
                offset: Offset(8.w, -8.h),
                padding: EdgeInsets.all(2.r),
                backgroundColor: Colors.white,
                alignment: Alignment.topRight,
                label: CircleAvatar(
                  radius: 6.r,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    state.model.list.length.toString(),
                    style: TextStyle(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: const AppBarIcon(
                  path: DataAssets.iconCart,
                ),
              ),
            ),
          );
        } else {
          return const AppBarIcon(
            path: DataAssets.iconCart,
          );
        }
      },
    );
  }
}
