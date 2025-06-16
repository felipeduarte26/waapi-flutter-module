import '../repositories/get_native_permission_storage_repository.dart';
import '../types/attachment_domain_types.dart';

abstract class GetNativePermissionStorageUsecase {
  GetNativePermissionStorageUsecaseCallback call();
}

class GetNativePermissionStorageUsecaseImpl implements GetNativePermissionStorageUsecase {
  final GetNativePermissionStorageRepository _getNativePermissionStorageRepository;

  const GetNativePermissionStorageUsecaseImpl({
    required GetNativePermissionStorageRepository getNativePermissionStorageRepository,
  }) : _getNativePermissionStorageRepository = getNativePermissionStorageRepository;

  @override
  GetNativePermissionStorageUsecaseCallback call() {
    return _getNativePermissionStorageRepository.call();
  }
}
