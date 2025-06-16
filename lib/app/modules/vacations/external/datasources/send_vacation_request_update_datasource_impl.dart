import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../../../core/types/either.dart';
import '../../domain/input_models/send_vacation_request_update_input_model.dart';
import '../../infra/datasources/send_vacation_request_update_datasource.dart';
import '../mappers/send_vacation_request_update_input_model_mapper.dart';

class SendVacationRequestUpdateDatasourceImpl implements SendVacationRequestUpdateDatasource {
  final RestService _restService;
  final SendVacationRequestUpdateInputModelMapper _sendVacationRequestUpdateInputModelMapper;

  const SendVacationRequestUpdateDatasourceImpl({
    required RestService restService,
    required SendVacationRequestUpdateInputModelMapper sendVacationRequestUpdateInputModelMapper,
  })  : _restService = restService,
        _sendVacationRequestUpdateInputModelMapper = sendVacationRequestUpdateInputModelMapper;

  @override
  Future<Either<List<String>, Unit>> call({
    required SendVacationRequestUpdateInputModel sendVacationRequestUpdateInputModel,
  }) async {
    final sendVacationRequestUpdateUpdatePath = '/vacationrequestupdate/${sendVacationRequestUpdateInputModel.id}';

    final sendVacationUpdateRequest = await _restService.legacyManagementPanelService().put(
          sendVacationRequestUpdateUpdatePath,
          body: _sendVacationRequestUpdateInputModelMapper.toMap(
            sendVacationRequestUpdateInputModel: sendVacationRequestUpdateInputModel,
          ),
        );

    final sendVacationRequestUpdateResponse = jsonDecode(sendVacationUpdateRequest.data!);

    if (sendVacationRequestUpdateResponse['vacationValidations'] != null) {
      final errorMessages = sendVacationRequestUpdateResponse['vacationValidations'][0]['messages'];
      List<String> errorsMessage = (errorMessages! as List).map((messages) => messages['message'] as String).toList();

      return left(errorsMessage);
    }

    return right(unit);
  }
}
