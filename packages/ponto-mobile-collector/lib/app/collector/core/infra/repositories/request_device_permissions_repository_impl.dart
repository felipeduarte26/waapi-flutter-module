import '../../../../../ponto_mobile_collector.dart';
import '../../domain/repositories/request_device_permissions_repository.dart';

class RequestDevicePermissionRepositoryImpl
    implements RequestDevicePermissionRepository {
  final ISharedPreferencesService _sharedPreferencesService;
  final IPermissionService _permissionService;

  const RequestDevicePermissionRepositoryImpl({
    required ISharedPreferencesService sharedPreferencesService,
    required IPermissionService permissionService,
  })  : _sharedPreferencesService = sharedPreferencesService,
        _permissionService = permissionService;

  @override
  Future<void> call() async {
    if (await _sharedPreferencesService.getRequestPermissionOnStatrtup()) {
      await _permissionService.requestAllPermission();
      await _sharedPreferencesService.setRequestPermissionOnStatrtup(
        value: false,
      );
    }
  }
}
