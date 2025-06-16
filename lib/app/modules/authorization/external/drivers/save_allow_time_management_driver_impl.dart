import '../../../../core/services/internal_storage/internal_storage_service.dart';
import '../../infra/drivers/save_allow_time_management_driver.dart';

class SaveAllowTimeManagementDriverImpl implements SaveAllowTimeManagementDriver {
  final InternalStorageService _internalStorageService;

  const SaveAllowTimeManagementDriverImpl({
    required InternalStorageService internalStorageService,
  }) : _internalStorageService = internalStorageService;

  @override
  Future<void> call({
    required bool isAllowToViewTimeManagement,
  }) async {
    await _internalStorageService.setBool(
      'isAllowToViewTimeManagement',
      value: isAllowToViewTimeManagement,
    );
  }
}
