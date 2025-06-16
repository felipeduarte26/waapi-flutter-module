import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../../../core/types/either.dart';
import '../../domain/input_models/send_cancelation_approved_request_input_model.dart';
import '../../infra/datasources/cancel_vacation_approved_request_datasource.dart';
import '../mappers/send_cancelation_approved_request_input_model_mapper.dart';

class CancelVacationApprovedRequestDatasourceImpl implements CancelVacationApprovedRequestDatasource {
  final RestService _restService;
  final SendCancelationApprovedRequestInputModelMapper _sendCancelationApprovedRequestInputModelMapper;

  const CancelVacationApprovedRequestDatasourceImpl({
    required SendCancelationApprovedRequestInputModelMapper sendCancelationApprovedRequestInputModelMapper,
    required RestService restService,
  })  : _restService = restService,
        _sendCancelationApprovedRequestInputModelMapper = sendCancelationApprovedRequestInputModelMapper;

  @override
  Future<Either<List<String>, Unit>> call({
    required String vacationSheduleToCancelId,
    required String employeeId,
  }) async {
    final cancelVacationRequestPath = '/vacationrequestupdate?employeeId=$employeeId';

    final bodySendCancelationApproved = _sendCancelationApprovedRequestInputModelMapper.toMap(
      sendCancelationApprovedRequestInputModel: SendCancelationApprovedRequestInputModel(
        vacationScheduleToCancelId: vacationSheduleToCancelId,
        employeeId: employeeId,
      ),
    );

    final cancelVacationRequest = await _restService.legacyManagementPanelService().post(
          cancelVacationRequestPath,
          body: bodySendCancelationApproved,
        );

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
