import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themar/core/design/unit/app_assets.dart';
import 'package:themar/core/design/unit/app_string.dart';

part 'state.dart';

class PhoneInputCubit extends Cubit<PhoneInputState> {
  PhoneInputCubit() : super(PhoneInputState());
  change(int index) {
    if (index == 10) {
      emit(PhoneInputStateChange(
          countryCode: DataString.codeKSA, icon: DataAssets.iconsKSA));
      print('KSA');
    } else if (index == 11) {
      emit(PhoneInputStateChange(
          countryCode: DataString.codeEGY, icon: DataAssets.iconsEGY));
      print('EGY');
    } else {
      emit(PhoneInputStateError(DataString.phoneError));
      print('error');
      print(index);
    }
  }
}
