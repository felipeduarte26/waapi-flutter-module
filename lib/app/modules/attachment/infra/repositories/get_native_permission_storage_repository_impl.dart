import '../../../../core/types/either.dart';
import '../../domain/failures/attachment_failure.dart';
import '../../domain/repositories/get_native_permission_storage_repository.dart';
import '../../domain/types/attachment_domain_types.dart';
import '../../infra/drivers/get_native_permission_storage_driver.dart';

class GetNativePermissionStorageRepositoryImpl implements GetNativePermissionStorageRepository {
  final GetNativePermissionStorageDriver _getNativePermissionStorageDriver;

  const GetNativePermissionStorageRepositoryImpl({
    required GetNativePermissionStorageDriver getNativePermissionStorageDriver,
  }) : _getNativePermissionStorageDriver = getNativePermissionStorageDriver;

  @override
  GetNativePermissionStorageUsecaseCallback call() async {
    try {
      final isGranted = await _getNativePermissionStorageDriver.call();

      if (isGranted) {
        return right(unit);
      }

      return left(const AttachmentDriverFailure());
    } catch (error) {
      return left(const AttachmentDriverFailure());
    }
  }
}
