import 'package:themar/core/design/unit/app_assets.dart';

class UserModel {
  late final User user;

  UserModel.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['data']??{});
  }
}

class User {
  late final int id;
  late final String fullName;
  late final String phone;
  late final String email;
  late final String image;
  late final int isBan;
  late bool isActive;
  late final int unreadNotifications;
  late final String userType;
  late final String token;
  late final Country country;
  late final City city;
  late final int userCartCount;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullname'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    isBan = json['is_ban'];
    isActive = json['is_active'];
    unreadNotifications = json['unread_notifications'];
    userType = json['user_type'];
    token = json['token'];
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
  late final String id;
  late final String name;

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Country {
  late final String id;
  late final String name;
  late final String nationality;
  late final String key;
  late final String flag;

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nationality = json['nationality'];
    key = json['key'];
    flag = json['flag'];
  }
}
