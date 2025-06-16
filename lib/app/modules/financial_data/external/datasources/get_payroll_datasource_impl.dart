import 'dart:convert';

import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_payroll_datasource.dart';
import '../../infra/models/payroll_model.dart';
import '../mappers/payroll_model_mapper.dart';

class GetPayrollDatasourceImpl implements GetPayrollDatasource {
  final RestService _restService;
  final PayrollModelMapper _payrollMapper;

  GetPayrollDatasourceImpl({
    required RestService restService,
    required PayrollModelMapper payrollMapper,
  })  : _restService = restService,
        _payrollMapper = payrollMapper;

  @override
  Future<List<PayrollModel>> call({
    required String employeeId,
    required PaginationRequirements paginationRequirements,
  }) async {
    final response = await _restService.legacyManagementPanelService().get(
      '/payrollregister/recents-paged/$employeeId',
      queryParameters: {
        'offset': paginationRequirements.offset,
        'limit': paginationRequirements.limit,
      },
    );

    final payrollDecode = jsonDecode(
      response.data!,
    );

    final List<PayrollModel> payrollsList = [];
    if (payrollDecode.containsKey('list')) {
      for (final payrollModel in payrollDecode['list']) {
        payrollsList.add(
          _payrollMapper.fromMap(
            map: payrollModel,
          ),
        );
      }
    }
    return payrollsList;
  }
}
