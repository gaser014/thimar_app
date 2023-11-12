import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themar/core/design/unit/app_string.dart';
import 'package:themar/core/logic/dio_helper.dart';
import 'package:themar/core/logic/helper_methods.dart';

part 'event.dart';
part 'state.dart';
part 'model.dart';
class CardBloc extends Bloc<CardEvents, CardState> {
  int index = 0;
  bool isLoading= false;
  final couponController = TextEditingController();

  CardBloc() : super(CardState()) {
    on<GetCardEvent>(_getCard);
    on<SendCouponEvent>(_sendCoupon);
  }

  Future<void> _getCard(CardEvents event, Emitter emit) async {
    emit(CardLoadingState());

    final response = await DioHelper().getData(endPoint: 'client/cart',haveToken: true,);
    if (response.isSuccess) {
      final model = CardData.fromJson(response.response!.data);
      emit(CardSuccessState(model: model));
    }
    else{
      emit(CardFieldState(message: response.message.toString()));
    }
  }
  Future<void> _sendCoupon(SendCouponEvent event, Emitter emit) async {
    emit(CardLoadingState());

    final response = await DioHelper().sendData(endPoint: '/client/cart/apply_coupon',haveToken: true,
    data: {
      'code':couponController.text
    });
    if(couponController.text.isNotEmpty){

      emit(CouponLoadingState());
    if (response.isSuccess) {
      final model = Coupon.fromJson(response.response!.data);
      showMessage(message: model.message,type: MassageType.success);
      emit(CouponSuccessState(model: model));
    }
    else{
      showMessage(message: response.message.toString());

      emit(CouponFieldState(message: response.message.toString()));
    }
  }}

}