import '../../../../core/types/either.dart';
import '../../domain/failures/settings_failure.dart';
import '../../domain/repositories/get_current_version_repository.dart';
import '../../domain/types/settings_domain_types.dart';
import '../drivers/get_current_version_driver.dart';

class GetCurrentVersionRepositoryImpl implements GetCurrentVersionRepository {
  final GetCurrentVersionDriver _getCurrentVersionDriver;

  const GetCurrentVersionRepositoryImpl({
    required GetCurrentVersionDriver getCurrentVersionDriver,
  }) : _getCurrentVersionDriver = getCurrentVersionDriver;

  @override
  GetCurrentVersionUsecaseCallback call() async {
    try {
      final version = await _getCurrentVersionDriver.call();

      return right(version);
    } catch (error) {
      return left(const SettingsDriverFailure());
    }
  }
}
