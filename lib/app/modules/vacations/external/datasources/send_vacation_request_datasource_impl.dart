import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../../../core/types/either.dart';
import '../../domain/input_models/send_vacation_request_input_model.dart';
import '../../infra/datasources/send_vacation_request_datasource.dart';
import '../mappers/send_vacation_request_input_model_mapper.dart';

class SendVacationRequestDatasourceImpl implements SendVacationRequestDatasource {
  final RestService _restService;
  final SendVacationRequestInputModelMapper _sendVacationRequestInputModelMapper;

  const SendVacationRequestDatasourceImpl({
    required RestService restService,
    required SendVacationRequestInputModelMapper sendVacationRequestInputModelMapper,
  })  : _restService = restService,
        _sendVacationRequestInputModelMapper = sendVacationRequestInputModelMapper;

  @override
  Future<Either<List<String>, Unit>> call({
    required SendVacationRequestInputModel sendVacationRequestInputModel,
  }) async {
    final sendVacationRequestPath = '/vacationrequestupdate?employeeId=${sendVacationRequestInputModel.employeeId}';
    final sendVacationRequest = await _restService.legacyManagementPanelService().post(
          sendVacationRequestPath,
          body: _sendVacationRequestInputModelMapper.toMap(
            sendVacationRequestInputModel: sendVacationRequestInputModel,
          ),
        );

    final sendVacationRequestResponse = jsonDecode(sendVacationRequest.data!);

    if (sendVacationRequestResponse['vacationValidations'] != null) {
      final errorMessages = sendVacationRequestResponse['vacationValidations'][0]['messages'];
      List<String> errorsMessage = (errorMessages! as List).map((messages) => messages['message'] as String).toList();

      return left(errorsMessage);
    }

    return right(unit);
  }
}
