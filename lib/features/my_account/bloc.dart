import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/features/auth/login/model.dart';
import '../../core/logic/dio_helper.dart';
import '../../core/logic/helper_methods.dart';
part 'events.dart';
part 'states.dart';
class MyAccountBloc extends Bloc<MyAccountEvents, MyAccountStates> {
  MyAccountBloc() : super(MyAccountStates()) {
    on<MyAccountEvent>(_getMyAccount);
  }

  Future<void> _getMyAccount(MyAccountEvent event, Emitter emit) async {
    emit(MyAccountLoadingState());

    final response = await DioHelper().getData(endPoint: 'client/profile');
    if (response.isSuccess) {
      final model = UserModel.fromJson(response.response!.data);
      emit(MyAccountSuccessState(model: model));
    }
    else{
      emit(MyAccountFieldState(message: response.message.toString()));
    }
  }

}