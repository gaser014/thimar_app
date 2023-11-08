
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/logic/dio_helper.dart';
import 'package:themar/core/logic/helper_methods.dart';
part 'state.dart';

part 'event.dart';

class FavBloc extends Bloc<FavEvents, FavState> {
bool isFav=false;
static int currentIndex = 0;

  FavBloc() : super(FavState()) {
    on<FavEvent>(_addFav);
    on<UnFavEvent>(_removeFav);
  }

  Future<void> _addFav(FavEvent event, Emitter emit) async {
      emit(FavLoadingState());
      final response = await DioHelper().sendData(
        endPoint: "client/products/${event.id}/add_to_favorite",
        haveToken: true,

      );
      print(response.response!.data);
      if (response.isSuccess) {
        isFav=true;
showMessage(message: response.message,type: MassageType.success);
        emit(FavSuccessState());
      } else {
        showMessage(message: response.message);

        emit(FavFieldState(message: response.message));
      }
    }
  Future<void> _removeFav(UnFavEvent event, Emitter emit) async {
      emit(FavLoadingState());
      final response = await DioHelper().sendData(
        endPoint: "client/products/${event.id}/remove_from_favorite",
        haveToken: true,

      );
      print(response.response!.data);
      if (response.isSuccess) {
        isFav=false;
showMessage(message: response.message,type: MassageType.success);
        emit(FavSuccessState());
      } else {
        showMessage(message: response.message);

        emit(FavFieldState(message: response.message));
      }
    }
  }

