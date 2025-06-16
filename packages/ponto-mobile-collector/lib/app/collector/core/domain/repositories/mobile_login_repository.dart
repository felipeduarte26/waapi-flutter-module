import '../../infra/utils/enum/environment_enum.dart';
import '../entities/mobile_login_usecase_return.dart';

abstract class MobileLoginRepository {
  Future<MobileLoginUsecaseReturn?> call(EnvironmentEnum environmentEnum,);
}
