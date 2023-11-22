import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/logic/dio_helper.dart';
import 'package:themar/core/logic/helper_methods.dart';

part 'states.dart';

part 'events.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvents, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordState()) {
    on<ResetPasswordEvent>(_reset);
  }

  Future<void> _reset(
      ResetPasswordEvent event, Emitter<ResetPasswordState> emit) async {
    emit(ResetPasswordLoadingState());

    final response = await DioHelper()
        .sendData(endPoint: 'reset_password', data: event.date);

    if (response.isSuccess) {
      emit(ResetPasswordSuccessState(message: response.message));
    } else {
      emit(ResetPasswordFailedState(
        message: response.message,
      ));
    }
  }
}
