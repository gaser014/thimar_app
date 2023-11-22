import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_assets.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/design/widget/app_input.dart';
import 'package:themar/core/design/widget/custom_app_bar.dart';
import 'package:themar/core/design/widget/image.dart';
import 'package:themar/core/logic/helper_methods.dart';

import 'package:themar/views/home/view.dart';

import '../../../../../../features/products/bloc.dart';
import '../../products/view.dart';


class CategoriesDetailsView extends StatefulWidget {
  final String name;
  final int id;

  const CategoriesDetailsView({
    Key? key,
    required this.id,
    required this.name,
  }) : super(key: key);

  @override
  State<CategoriesDetailsView> createState() => _CategoriesDetailsViewState();
}

class _CategoriesDetailsViewState extends State<CategoriesDetailsView> {
  final searchController = TextEditingController();
  late ProductsBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of(context);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title:  widget.name,onTap: () {
        navigateTo(const HomeView());
      }),
        body: Padding(
      padding: EdgeInsets.all(16.r),
      child: ListView(
        children: [
       BlocBuilder(
            bloc: bloc,
            builder: (context, state) => AppInput(
              isFilled: true,
              label: DataString.search,
              image: DataAssets.iconSearch,
              validator: (value) {
                return null;
              },
              onChanged: (value) {
                bloc.add(ProductEvent(keyword: value));
                setState(() {
                });
              },
              suffixIcon: Padding(
                padding: EdgeInsets.all(8.0.r),
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  child: const AppImage(
                    path: DataAssets.iconSetting,
                    fit: BoxFit.scaleDown,
                    color: Colors.white,
                  ),
                ),
              ),

              controller: searchController,
            ),
          ),

          SizedBox(
            height: 20.h,
          ),
          ProductView(
            type: ProductType.category,
            keyword: searchController.text,
            id: widget.id,
          ),
        ],
      ),
    ));
  }
}
