import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/widget/app_bar_icon.dart';
import 'package:themar/core/design/widget/image.dart';
import 'package:themar/core/logic/dio_helper.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/feature/products/bloc.dart';

part 'state.dart';

part 'event.dart';
part 'view.dart';

class FavBloc extends Bloc<FavEvents, FavState> {
  static int currentIndex = 0;

  FavBloc() : super(FavState()) {
    on<FavEvent>(_addFav);
  }

  Future<void> _addFav(FavEvent event, Emitter emit) async {
    emit(FavLoadingState());

    final response = await DioHelper().sendData(
      endPoint:
          "client/products/${event.product.id}/${event.product.isFavorite ? "remove_from_favorite" : "add_to_favorite"}",
      haveToken: true,
    );
    debugPrint(response.response?.data['message']);
    if (response.isSuccess) {
      event.product.isFavorite = !event.product.isFavorite;
      event.product.favoriteIcon =
          event.product.getFavoriteIcon(event.product.isFavorite);
      showMessage(message: response.message, type: MassageType.success);
      emit(FavSuccessState(event.product));
    } else {
      showMessage(message: response.message);

      emit(FavFieldState(message: response.message));
    }
  }
}
