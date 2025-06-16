/// This interface describe all the methods that are needed to save data to internal storage.
abstract class InternalStorageService {
  String? getString(String key);

  List<String>? getStringList(String key);

  Future<bool> setString(
    String key,
    String value,
  );

  Future<bool> setStringList(
    String key,
    List<String> value,
  );

  Future<bool> setInt(
    String key,
    int value,
  );

  Future<bool> setBool(
    String key, {
    required bool value,
  });

  int? getInt(String key);

  bool? getBool(String key);

  Future<bool> remove(String key);

  Future<bool> clearAll();
}
