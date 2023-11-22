
import 'package:themar/core/design/unit/app_assets.dart';

class UserModel {
  late final User user;

  UserModel.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['data']??{});
  }
}

class User {
  late final int id,isBan,unreadNotifications,userCartCount;
  late final String fullName,phone,email,image,token,userType;
  late bool isActive;
  late final Country country;
  late final City city;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    fullName = json['fullname']??'';
    phone = json['phone']??'';
    email = json['email']??'';
    image = json['image']??'';
    isBan = json['is_ban']??0;
    isActive = json['is_active']??false;
    unreadNotifications = json['unread_notifications']??0;
    userType = json['user_type']??'';
    token = json['token']??'';
    city = City.fromJson(json['city'] ?? {"id": "8", "name": "القاهرة"});
    country = Country.fromJson(json['country'] ??
        {
          'id': '0',
          'name': 'مصر',
          "nationality": 'مصري',
          "key": 'EG',
          "flag": DataAssets.iconsEGY,
        });
    userCartCount = json['user_cart_count'];
  }
}

class City {
  late final String id, name;
  City.fromJson(Map<String, dynamic> json) {
    id = json['id']??'0';
    name = json['name']??'القاهرة';
  }
}

class Country {
  late final String id,name,nationality,key,flag;

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id']??'0';
    name = json['name']??'مصر';
    nationality = json['nationality']??'مصري';
    key = json['key']??'EG';
    flag = json['flag']??DataAssets.iconsEGY;
  }
}
