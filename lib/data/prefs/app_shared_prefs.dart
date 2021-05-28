
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppSharedPreferences {
  final SharedPreferences _sharedPreferences;

  AppSharedPreferences(this._sharedPreferences);

  Future<bool> saveString(String key, String value);
  Future<String> getString(String key);
  Future<bool> saveBoolean(String key, bool value);
  Future<bool> getBoolean(String key, bool defaultValue);
}
