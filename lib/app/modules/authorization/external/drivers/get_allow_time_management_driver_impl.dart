import '../../../../core/services/internal_storage/internal_storage_service.dart';
import '../../infra/drivers/get_allow_time_management_driver.dart';

class GetAllowTimeManagementDriverImpl implements GetAllowTimeManagementDriver {
  final InternalStorageService _internalStorageService;

  const GetAllowTimeManagementDriverImpl({
    required InternalStorageService internalStorageService,
  }) : _internalStorageService = internalStorageService;

  @override
  bool? call() {
    return (_internalStorageService.getBool('isAllowToViewTimeManagement') ?? false);
  }
}
