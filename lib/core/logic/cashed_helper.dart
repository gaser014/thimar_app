import 'package:shared_preferences/shared_preferences.dart';
import 'package:themar/view/auth/login/model.dart';

class CachedHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> clear() {
    return _prefs.clear();
  }

  static Future<void> saveData(User model) async {
    await _prefs.setString('name', model.fullName);
    await _prefs.setString('email', model.email);
    await _prefs.setString('phone', model.phone);
    await _prefs.setString('token', model.token);
    await _prefs.setBool('isActive', model.isActive);
    await _prefs.setString('city_id', model.city.id);
    await _prefs.setString('city_name', model.city.name);
  }

  static bool  isActive ()=> _prefs.getBool('isActive')??false;
static String  getToken ()=> _prefs.getString('token')??'';
  static bool isAuth() {
    return getToken().isEmpty;
  }
}
