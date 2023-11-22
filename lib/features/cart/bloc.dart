import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/logic/dio_helper.dart';
import 'package:themar/core/logic/helper_methods.dart';

import 'model.dart';

part 'events.dart';

part 'states.dart';

class CardBloc extends Bloc<CardEvents, CardStates> {
  bool isLoading = false;
  final couponController = TextEditingController();

  CardBloc() : super(CardStates()) {
    on<GetCardEvent>(_getCard);
    on<SendCouponEvent>(_sendCoupon);
    on<DeleteCardEvent>(_deleteCard);
    on<UpDateCardEvent>(_upDateCard);
  }

  Future<void> _getCard(GetCardEvent event, Emitter emit) async {
    print(event.massage);
    emit(CardLoadingState());

    final response = await DioHelper().getData(
      endPoint: 'client/cart',
      haveToken: true,
    );
    if (response.isSuccess) {
      final modelDate = CardData.fromJson(response.response!.data);
      print('print from card bloc ${modelDate.list.length}');
      print('*'*150);
      emit(CardSuccessState(model: modelDate));
    } else {
      emit(CardFieldState(message: response.message.toString()));
    }
  }

  Future<void> _sendCoupon(SendCouponEvent event, Emitter emit) async {
    emit(CouponLoadingState());
    final response = await DioHelper().sendData(
        endPoint: 'client/cart/apply_coupon',
        haveToken: true,
        data: {'code': couponController.text});
    if (couponController.text.isNotEmpty) {
      emit(CouponLoadingState());
      if (response.isSuccess) {
        final model = Coupon.fromJson(response.response!.data);
        emit(CouponSuccessState(model: model));
      } else {
        emit(CouponFieldState(message: response.message.toString()));
      }
    }
  }

  Future<void> _upDateCard(UpDateCardEvent event, Emitter emit) async {
    emit(UpDateCardLoadingState());
    final response = await DioHelper().upDateData(
        endPoint: 'client/cart/${event.model.list[event.index].id}',
        haveToken: true,
        data: {
          'amount': event.model.list[event.index].amount + event.addAmount,
        });

    emit(UpDateCardLoadingState());
    if (response.isSuccess) {
      event.model.upDateCard(
        event.index,
        event.addAmount,
      );
      emit(CardSuccessState(model: event.model));
    } else {
      emit(UpDateCardFieldState(message: response.message.toString()));
    }
  }

  Future<void> _deleteCard(DeleteCardEvent event, Emitter emit) async {
    emit(DeleteCardLoadingState());

    final response = await DioHelper().deleteData(
      endPoint: '/client/cart/delete_item/${event.model.list[event.index].id}',
      haveToken: true,
    );
    if (response.isSuccess) {
      event.model.deleteCard(event.index);

      emit(CardSuccessState(
        model: event.model,
      ));
    } else {
      emit(DeleteCardFieldState(message: response.message.toString()));
    }
  }
}
