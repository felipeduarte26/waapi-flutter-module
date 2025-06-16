abstract class SaveClockingConfigurationDriver {
  Future<void> call({
    required bool? allowGpoOnApp,
    required String key,
  });
}
