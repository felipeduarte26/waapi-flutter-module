import '../datasources/preferences_storage_local_datasource.dart';

abstract class PreferencesStorageRepository {
  Future<bool> readSAMLOnboardingEnabled();
  Future<void> writeSAMLOnboardingEnabled(bool value);
}

class PreferencesStorageRepositoryImpl implements PreferencesStorageRepository {
  late final PreferencesStorageDatasource _datasource;

  PreferencesStorageRepositoryImpl({PreferencesStorageDatasource? datasource}) {
    _datasource = datasource ?? PreferencesStorageLocalDatasource();
  }

  @override
  Future<bool> readSAMLOnboardingEnabled() async {
    return await _datasource.readSAMLOnboardingEnabled();
  }

  @override
  Future<void> writeSAMLOnboardingEnabled(bool value) async {
    await _datasource.writeSAMLOnboardingEnabled(value);
  }
}
