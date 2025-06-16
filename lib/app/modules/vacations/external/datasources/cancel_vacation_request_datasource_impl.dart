import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../../../core/types/either.dart';
import '../../infra/datasources/cancel_vacation_request_datasource.dart';

class CancelVacationRequestDatasourceImpl implements CancelVacationRequestDatasource {
  final RestService _restService;

  const CancelVacationRequestDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<Either<List<String>, Unit>> call({
    required String idVacation,
  }) async {
    final cancelVacationRequestPath = '/vacationrequestupdate/cancel/$idVacation';

    final cancelVacationRequest = await _restService.legacyManagementPanelService().put(cancelVacationRequestPath);

    if (cancelVacationRequest.data != null) {
      final cancelVacationRequestResponse = jsonDecode(cancelVacationRequest.data!);

      if (cancelVacationRequestResponse['vacationValidations'] != null) {
        final errorMessages = cancelVacationRequestResponse['vacationValidations'][0]['messages'];
        List<String> errorsMessage = (errorMessages! as List).map((messages) => messages['message'] as String).toList();

        return left(errorsMessage);
      }
    }
    return right(unit);
  }
}
