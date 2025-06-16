import 'dart:convert';

import 'package:collection/collection.dart';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_active_contract_datasource.dart';
import '../../infra/models/active_contract_model.dart';
import '../mappers/active_contract_model_mapper.dart';

class GetActiveContractDatasourceImpl implements GetActiveContractDatasource {
  final RestService _restService;
  final ActiveContractModelMapper _activeContractModelMapper;

  const GetActiveContractDatasourceImpl({
    required RestService restService,
    required ActiveContractModelMapper activeContractModelMapper,
  })  : _restService = restService,
        _activeContractModelMapper = activeContractModelMapper;

  @override
  Future<ActiveContractModel?> call() async {
    final activeContracts = await _restService.legacyManagementPanelService().get('/employee/person-active-employees');

    final activeContractsDecoded = jsonDecode(activeContracts.data!);

    final activeContractsModels = (activeContractsDecoded as List).map(
      (activeContract) {
        return _activeContractModelMapper.fromMap(
          map: activeContract,
        );
      },
    ).toList();

    return activeContractsModels.firstOrNull;
  }
}
