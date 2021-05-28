import 'package:flutter_architecture/data/prefs/app_shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferencesImpl extends AppSharedPreferences {
  final SharedPreferences _sharedPreferences;

  AppSharedPreferencesImpl(this._sharedPreferences)
      : super(_sharedPreferences);

  @override
  Future<bool> saveString(String key, String value) => _sharedPreferences.setString(key, value);

  @override
  Future<String> getString(String key) => Future<String>.value(_sharedPreferences.getString(key));

  Future<bool> saveBoolean(String key, bool value) => _sharedPreferences.setBool(key, value);

  Future<bool> getBoolean(String key, bool defaultValue) => Future<bool>.value(_sharedPreferences.getBool(key) ?? defaultValue);
}
