import '../../domain/entities/mobile_login_usecase_return.dart';
import '../utils/enum/environment_enum.dart';

abstract class MobileLoginDataSource {
  Future<MobileLoginUsecaseReturn?> call(
    EnvironmentEnum environmentEnum,
  );
}
