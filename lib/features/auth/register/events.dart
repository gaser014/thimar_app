part of 'bloc.dart';

class RegisterEvents {}

class RegisterEvent extends RegisterEvents {
  CitiesModel? selectedCity;
late  bool isEG ;
  final String phone, name, password, rePassword;
late final  Map<String, dynamic>? data;
  RegisterEvent({
    required this.selectedCity,
    required this.phone,
    required this.name,
    required this.password,
    required this.rePassword,
  }){
    if(phone.length==10){
      isEG=false;
    }
    data= {
      "fullname": name,
    "password": password,
    "password_confirmation": rePassword,
    "phone": phone,
    "country_id":isEG?null: 1,
    "city_1": selectedCity!.id,
  };
  }
}
