import '../../../internal_storage/internal_storage_service.dart';
import '../../data/integration_user_repository.dart';

class IntegrationUserRepositoryImpl implements IntegrationUserRepository {
  final InternalStorageService _internalStorageService;

  const IntegrationUserRepositoryImpl({required InternalStorageService internalStorageService})
      : _internalStorageService = internalStorageService;

  @override
  Future<void> saveIntegrationUser(String? integrationUser) async {
    if (integrationUser != null && integrationUser.isNotEmpty) {
      await _internalStorageService.setString(key, integrationUser);
      return;
    }
    
    await _internalStorageService.remove(key);
  }

  @override
  String? getIntegrationUser() {
    String? result = _internalStorageService.getString(key);
    return result;
  }

  @override
  Future<void> deleteIntegrationUser() async {
    await _internalStorageService.remove(key);
  }

  String get key => 'integrationUser';
}
