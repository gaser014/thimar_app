part of 'bloc.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (BuildContext context, CategoriesState state) {
          if (state is CategoriesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoriesSuccessState) {
            return SizedBox(
              height: 100.h*1.sh/746.h,
              width: 74.w,
              child: ListView.separated(
                itemCount: state.model.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  print(state.model[index].name);
                  print(state.model.length);
                  return _ItemCategories(
                    model: state.model[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 16.w,
                  );
                },
              ),
            );
          } else if (state is CategoriesFieldState) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class _ItemCategories extends StatelessWidget {
  final CategoriesModel model;

  const _ItemCategories({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            width: 73.w,
            height: 73.h*1.sh/746.h,
            decoration: BoxDecoration(
              color: const Color(0xff4C8613).withAlpha(13),
              borderRadius: BorderRadius.circular(9.r),
            ),
            padding: EdgeInsets.all(6.r),
            child: AppImage(
              path: model.image,
              fit: BoxFit.scaleDown,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            model.name,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          )
        ],


      ),
      onTap: () {
        navigateTo(CategoriesDetailsView(
          id: model.id,
          name: model.name,
        ));
      },
    );
  }
}
