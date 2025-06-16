import '../repositories/get_g5_connector_repository.dart';
import '../types/g5_domain_types.dart';

abstract class GetG5ConnectorUsecase {
  GetG5ConnectorUsecaseCallback call();
}

class GetG5ConnectorUsecaseImpl implements GetG5ConnectorUsecase {
  final GetG5ConnectorRepository _getG5ConnectorRepository;

  GetG5ConnectorUsecaseImpl({
    required GetG5ConnectorRepository getG5ConnectorRepository,
  }) : _getG5ConnectorRepository = getG5ConnectorRepository;

  @override
  GetG5ConnectorUsecaseCallback call() {
    return _getG5ConnectorRepository.call();
  }
}
