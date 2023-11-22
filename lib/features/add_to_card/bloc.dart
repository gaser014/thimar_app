import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/logic/dio_helper.dart';
import 'package:themar/core/logic/helper_methods.dart';

import '../products/bloc.dart';

part 'events.dart';

part 'states.dart';

class AddToCardBloc extends Bloc<AddToCardEvents, AddToCardStates> {
  AddToCardBloc() : super(AddToCardStates()) {
    on<AddToCardEvent>(_addToCardEvent);
  }

  Future<void> _addToCardEvent(AddToCardEvent event, Emitter emit) async {
    emit(
      AddToCardLoadingState(id: event.model.id),
    );

    final response = await DioHelper().sendData(
      endPoint: "client/cart",
      data: {
        "product_id": event.model.id,
        "amount": event.model.count,
      },
      haveToken: true,
    );
    debugPrint(response.response?.data['message']);
    if (response.isSuccess) {
      emit(AddToCardSuccessState(
          message: response.message, isGetCard: event.isNavigateToDetails));
    } else {
      emit(AddToCardFieldState(message: response.message));
    }
  }
}
