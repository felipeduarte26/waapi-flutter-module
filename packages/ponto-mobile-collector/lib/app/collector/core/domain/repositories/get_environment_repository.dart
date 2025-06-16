import '../../../../../ponto_mobile_collector.dart';

abstract class GetEnvironmentRepository {
  Future<EnvironmentEnum> call();
}
