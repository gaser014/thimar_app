import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/logic/dio_helper.dart';

part 'event.dart';
part 'state.dart';
part 'model.dart';
class CardBloc extends Bloc<CardEvents, CardState> {
  int index = 0;
  CardBloc() : super(CardState()) {
    on<GetCardEvent>(_getCard);
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

}