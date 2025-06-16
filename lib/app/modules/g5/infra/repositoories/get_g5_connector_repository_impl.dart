import '../../../../core/types/either.dart';
import '../../domain/failures/g5_failure.dart';
import '../../domain/repositories/get_g5_connector_repository.dart';
import '../../domain/types/g5_domain_types.dart';
import '../datasources/get_g5_connector_datasource.dart';

class GetG5ConnectorRepositoryImpl implements GetG5ConnectorRepository {
  final GetG5ConnectorDatasource _getG5ConnectorDatasource;

  GetG5ConnectorRepositoryImpl({
    required GetG5ConnectorDatasource getG5ConnectorDatasource,
  }) : _getG5ConnectorDatasource = getG5ConnectorDatasource;

  @override
  GetG5ConnectorUsecaseCallback call() async {
    try {
      final g5Connector = await _getG5ConnectorDatasource.call();
      return right(g5Connector);
    } catch (error) {
      return left(
        G5DatasourceFailure(
          message: error.toString(),
        ),
      );
    }
  }
}
