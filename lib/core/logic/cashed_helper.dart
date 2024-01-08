// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/login/model.dart';

class CachedHelper {
  static late SharedPreferences _prefs;
  static void cacheLanguageCode(String languageCode) {
    _prefs.setString("LOCALE", languageCode);
  }

  static String getCachedLanguageCode() {
    final cachedLanguageCode = _prefs.getString("LOCALE");
    if (cachedLanguageCode != null) {
      return cachedLanguageCode;
    } else {
      return "en";
    }
  }

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> clear() {
    return _prefs.clear();
  }

  static Future<void> saveData({required User model}) async {
    await _prefs.setString('name', model.fullName);
    await _prefs.setString('email', model.email);
    await _prefs.setString('image', model.image);
    await _prefs.setString('phone', model.phone);
    await _prefs.setString('token', model.token);
    await _prefs.setBool('isActive', model.isActive);
    await _prefs.setString('city_id', model.city.id);
    await _prefs.setString('city_name', model.city.name);
  }

  static bool isActive() => _prefs.getBool('isActive') ?? false;
  static String getToken() => _prefs.getString('token') ?? '';
  static String getFullName() => _prefs.getString('name') ?? '';
  static String getImageProfile() => _prefs.getString('image') ?? '';
  static String getEmail() => _prefs.getString('email') ?? '';
  static String getPhone() => _prefs.getString('phone') ?? '';
  static String getCityName() => _prefs.getString('city_name') ?? '';
  static String getCityId() => _prefs.getString('city_id') ?? '';
  static bool isAuth() {
    return getToken().isEmpty;
  }
}
