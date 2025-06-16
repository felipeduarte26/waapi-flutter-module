import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_vacation_schedule_individual_datasource.dart';

class GetVacationScheduleIndividualDatasourceImpl implements GetVacationScheduleIndividualDatasource {
  final RestService _restService;

  const GetVacationScheduleIndividualDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<bool> call({
    required String employeeId,
    required String vacationId,
  }) async {
    final vacationPath = '/vacation-schedule/individual/$vacationId?activeEmployeeId=$employeeId/';
    final vacationResponse = await _restService.legacyManagementPanelService().get(
          vacationPath,
        );

    final vacationResponseDecoded = jsonDecode(vacationResponse.data!);
    final result = vacationResponseDecoded['vacationRequestUpdateId'] != null &&
        vacationResponseDecoded['vacationRequestUpdateId'] != '';
    return result;
  }
}
