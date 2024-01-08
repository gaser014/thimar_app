import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:themar/core/logic/dio_helper.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/features/products/bloc.dart';

part 'states.dart';

part 'events.dart';

class FavBloc extends Bloc<FavEvents, FavStates> {
  static int currentIndex = 0;

  FavBloc() : super(FavStates()) {
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
      emit(FavSuccessState(product: event.product, message: response.message));
    } else {
      showMessage(message: response.message);

      emit(FavFieldState(message: response.message));
    }
  }
}
