import 'dart:convert';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import '../../internal_storage/internal_storage_service.dart';
import '../../rest_client/rest_service.dart';
import 'drivers/get_clocking_configuration_driver_impl.dart';
import 'drivers/save_clocking_configuration_driver_impl.dart';

class GetClockingConfiguration {
  final RestService _restService;
  final GetClockingConfigurationDriverImpl _getClockingConfigurationDriverImpl;
  final SaveClockingConfigurationDriverImpl _saveClockingConfigurationDriverImpl;
  final GetStoredTokenUsecase _getStoredTokenUsecase;

  GetClockingConfiguration({
    required RestService restService,
    required InternalStorageService internalStorageService,
    required GetStoredTokenUsecase getStoredTokenUsecase,
  })  : _restService = restService,
        _getClockingConfigurationDriverImpl =
            GetClockingConfigurationDriverImpl(internalStorageService: internalStorageService),
        _saveClockingConfigurationDriverImpl =
            SaveClockingConfigurationDriverImpl(internalStorageService: internalStorageService),
        _getStoredTokenUsecase = getStoredTokenUsecase;

  Future<bool> call() async {
    late final Token? token;
    bool allowGpoOnApp = false;
    bool? hasClockingConfiguration = false;

    hasClockingConfiguration = _getClockingConfigurationDriverImpl.call(key: keyAllowGpoOnApp);

    try {
      final tokenResult = await _getStoredTokenUsecase.call(const UserName());
      token = tokenResult.token;
    } catch (e) {
      return hasClockingConfiguration ?? false;
    }

    final headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': '${token!.tokenType} ${token.accessToken}',
    };

    try {
      final response =
          await _restService.pontoMobileService().post('/queries/getClockingConfiguration', headers: headers);

      final permissionGpoDecode = jsonDecode(
        response.data!,
      );

      Map<String, dynamic> configurationGpoOnApp = permissionGpoDecode[keyClockingConfiguration];
      allowGpoOnApp = configurationGpoOnApp[keyAllowGpoOnApp];

      _saveClockingConfigurationDriverImpl.call(allowGpoOnApp: allowGpoOnApp, key: keyAllowGpoOnApp);
    } catch (e) {
      allowGpoOnApp = _getClockingConfigurationDriverImpl.call(key: keyAllowGpoOnApp) ?? false;
    }

    return allowGpoOnApp;
  }

  String get keyAllowGpoOnApp => 'allowGpoOnApp';

  String get keyClockingConfiguration => 'clockingConfiguration';
}
