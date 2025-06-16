import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_employee_company_name_datasource.dart';

class GetEmployeeCompanyNameDatasourceImpl implements GetEmployeeCompanyNameDatasource {
  final RestService _restService;

  const GetEmployeeCompanyNameDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<String> call({
    required String employeeId,
  }) async {
    final jsonResultData = await _restService.analytics().post(
      '/queries/employeeObjectOfAnalysis',
      body: {'employeeId': employeeId},
    );

    final resultMapData = json.decode(jsonResultData.data!) as Map<String, dynamic>;

    return resultMapData['result']['companyName'] ?? '';
  }
}
