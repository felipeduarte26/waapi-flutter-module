/// This interface describes all the methods needed to open app settings natively
abstract class NativeSettingsService {
  Future<bool> openNativeSettings();
}
