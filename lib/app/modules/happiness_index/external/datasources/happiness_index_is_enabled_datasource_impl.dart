import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/happiness_index_is_enabled_datasource.dart';

class HappinessIndexIsEnabledDatasourceImpl implements HappinessIndexIsEnabledDatasource {
  final RestService _restService;

  const HappinessIndexIsEnabledDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<bool> call() async {
    final isEnabledReturn = await _restService.happinessIndexService().get(
          '/queries/isEnabled',
        );

    return jsonDecode(isEnabledReturn.data!)['enabled'] as bool;
  }
}
