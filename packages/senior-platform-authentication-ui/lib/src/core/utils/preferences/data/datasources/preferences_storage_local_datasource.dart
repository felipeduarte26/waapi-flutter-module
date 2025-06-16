import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/entities/preferences_keys.dart';

abstract class PreferencesStorageDatasource {
  Future<bool> readSAMLOnboardingEnabled();
  Future<void> writeSAMLOnboardingEnabled(bool value);
}

class PreferencesStorageLocalDatasource
    implements PreferencesStorageDatasource {
  late final FlutterSecureStorage _storage;

  PreferencesStorageLocalDatasource({FlutterSecureStorage? storage}) {
    _storage = storage ?? const FlutterSecureStorage();
  }

  @override
  Future<bool> readSAMLOnboardingEnabled() async {
    final strValue =
        await _storage.read(key: PreferencesStorageKeys.samlOnboardingEnabled);

    if (strValue != null) {
      return json.decode(strValue);
    }

    return true;
  }

  @override
  Future<void> writeSAMLOnboardingEnabled(bool value) async {
    await _storage.write(
        key: PreferencesStorageKeys.samlOnboardingEnabled,
        value: json.encode(value));
  }
}
