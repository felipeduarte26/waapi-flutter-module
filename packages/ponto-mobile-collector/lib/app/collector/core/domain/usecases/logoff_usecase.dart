import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';

import '../../../../../ponto_mobile_collector.dart';
import 'check_conection_usecase.dart';
import 'deauthenticate_user_usecase.dart';
import 'get_facial_recognition_is_enable_usecase.dart';

/// Deauthenticates and wipes all user information
/// [cleanTenant] if true, will remove the tenant from the shared preferences
abstract class ILogoffUsecase {
  Future<void> call({
    bool cleanTenant = false,
  });
}

class LogoffUsecase implements ILogoffUsecase {
  final FlutterGryfoLib _gryfoLib;
  final ICollectorModuleService _collectorModuleService;
  final ISharedPreferencesService _sharedPreferencesService;
  final HasConnectivityUsecase _hasConnectivityUsecase;
  final GetFacialRecognitionIsEnableUsecase
      _getFacialRecognitionIsEnableUsecase;
  final DeauthenticateUserUsecase _deauthenticateUserUsecase;
  final LogService _logService;

  const LogoffUsecase({
    required FlutterGryfoLib gryfoLib,
    required ICollectorModuleService collectorModuleService,
    required ISharedPreferencesService sharedPreferencesService,
    required HasConnectivityUsecase hasConnectivityUsecase,
    required GetFacialRecognitionIsEnableUsecase
        getFacialRecognitionIsEnableUsecase,
    required DeauthenticateUserUsecase deauthenticateUserUsecase,
    required LogService logService,
  })  : _gryfoLib = gryfoLib,
        _collectorModuleService = collectorModuleService,
        _sharedPreferencesService = sharedPreferencesService,
        _hasConnectivityUsecase = hasConnectivityUsecase,
        _getFacialRecognitionIsEnableUsecase =
            getFacialRecognitionIsEnableUsecase,
        _deauthenticateUserUsecase = deauthenticateUserUsecase,
        _logService = logService;

  @override
  Future<void> call({bool cleanTenant = false}) async {
    if (cleanTenant) {
      await _sharedPreferencesService.removeTenant();
      _logService.saveLocalLog(
        exception: 'LogoffUsecase',
        stackTrace: 'tenant removed',
      );
    }

    var isOnline = await _hasConnectivityUsecase.call();

    if (isOnline && await _getFacialRecognitionIsEnableUsecase.call()) {
      await _gryfoLib.synchronizeExternalIds([]);
      _logService.saveLocalLog(
        exception: 'LogoffUsecase',
        stackTrace: 'gryfo local data faces removed',
      );
    }

    await _deauthenticateUserUsecase.call();

    await _collectorModuleService.finalize();

    _logService.saveLocalLog(
      exception: 'LogoffUsecase',
      stackTrace: 'successfully completed',
    );
  }
}
