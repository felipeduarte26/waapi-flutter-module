import '../../domain/entities/mobile_login_usecase_return.dart';
import '../../domain/repositories/mobile_login_repository.dart';
import '../datasources/mobile_login_datasource.dart';
import '../utils/enum/environment_enum.dart';

class MobileLoginRepositoryImpl implements MobileLoginRepository {
  late MobileLoginDataSource mobileLoginDataSource;

  MobileLoginRepositoryImpl(
    this.mobileLoginDataSource,
  );

  @override
  Future<MobileLoginUsecaseReturn?> call(EnvironmentEnum environmentEnum,) async {
    return mobileLoginDataSource.call(environmentEnum);
  }
}
