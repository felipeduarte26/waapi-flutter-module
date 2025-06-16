import 'package:shared_preferences/shared_preferences.dart';

import '../internal_storage_service.dart';

class SharedPreferencesStorageService implements InternalStorageService {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesStorageService({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  @override
  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  @override
  List<String>? getStringList(String key) {
    return _sharedPreferences.getStringList(key);
  }

  @override
  Future<bool> remove(String key) {
    return _sharedPreferences.remove(key);
  }

  @override
  Future<bool> setString(
    String key,
    String value,
  ) {
    return _sharedPreferences.setString(
      key,
      value,
    );
  }

  @override
  Future<bool> setStringList(
    String key,
    List<String> values,
  ) {
    return _sharedPreferences.setStringList(
      key,
      values,
    );
  }

  @override
  Future<bool> clearAll() {
    return _sharedPreferences.clear();
  }

  @override
  int? getInt(String key) {
    return _sharedPreferences.getInt(key);
  }

  @override
  Future<bool> setInt(
    String key,
    int value,
  ) {
    return _sharedPreferences.setInt(
      key,
      value,
    );
  }

  @override
  bool? getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  @override
  Future<bool> setBool(
    String key, {
    required bool value,
  }) {
    return _sharedPreferences.setBool(
      key,
      value,
    );
  }
}
