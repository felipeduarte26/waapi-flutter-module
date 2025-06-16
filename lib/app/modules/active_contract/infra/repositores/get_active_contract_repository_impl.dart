import '../../../../core/services/rest_client/rest_exception.dart';
import '../../../../core/types/either.dart';
import '../../domain/failures/active_contract_failure.dart';
import '../../domain/repositories/get_active_contract_repository.dart';
import '../../domain/types/active_contract_domain_types.dart';
import '../adapters/active_contract_entity_adapter.dart';
import '../datasources/get_active_contract_datasource.dart';

class GetActiveContractRepositoryImpl implements GetActiveContractRepository {
  final GetActiveContractDatasource _getActiveContractDatasource;
  final ActiveContractEntityAdapter _activeContractEntityAdapter;

  const GetActiveContractRepositoryImpl({
    required GetActiveContractDatasource getActiveContractDatasource,
    required ActiveContractEntityAdapter activeContractEntityAdapter,
  })  : _getActiveContractDatasource = getActiveContractDatasource,
        _activeContractEntityAdapter = activeContractEntityAdapter;

  @override
  GetActiveContractUsecaseCallback call() async {
    try {
      final activeContract = await _getActiveContractDatasource.call();

      if (activeContract != null) {
        final activeContractEntity = _activeContractEntityAdapter.fromModel(
          activeContractModel: activeContract,
        );

        return right(activeContractEntity);
      }

      return left(const NoActiveContractFoundFailure());
    } catch (error) {
      if (error is RestException && error.statusCode == 403) {
        return left(const NoActiveContractFoundFailure());
      }

      return left(const ActiveContractDatasourceFailure());
    }
  }
}
