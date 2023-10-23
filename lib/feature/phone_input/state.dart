part of 'cubit.dart';

class PhoneInputState {}

class PhoneInputStateChange extends PhoneInputState {
  final String countryCode;
  final String icon;
  PhoneInputStateChange(
      {this.countryCode = DataString.codeKSA, this.icon = DataAssets.iconsKSA});
}

class PhoneInputStateError extends PhoneInputState {
  final String message;
  PhoneInputStateError(this.message);
}
