

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/logic/dio_helper.dart';
import 'package:themar/core/logic/helper_methods.dart';
import 'package:themar/feature/products/bloc.dart';
import 'package:themar/view/home/home.dart';

part 'event.dart';
part 'state.dart';

class AddToCardBloc extends Bloc<AddToCardEvents, AddToCardState> {
  AddToCardBloc() : super(AddToCardState()) {
    on<AddToCardEvent>(_addToCardEvent);

  }
  Future<void> _addToCardEvent(AddToCardEvent event, Emitter emit) async {
    emit(AddToCardState());

    final response = await DioHelper().sendData(
      endPoint:
      "client/cart",
      data: {
        "product_id": event.model.id,
        "amount": event.model.count,
      },
      haveToken: true,
    );
    debugPrint(response.response?.data['message']);
    if (response.isSuccess) {

      showMessage(message: response.message, type: MassageType.success);
      emit(AddToCardSuccessState());
      navigateTo(const HomeView());
    } else {
      showMessage(message: response.message);

      emit(AddToCardFieldState(message: response.message));
    }
  }
}
