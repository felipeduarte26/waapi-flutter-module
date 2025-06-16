// ignore_for_file: unused_local_variable, unused_field

import '../../../../core/services/rest_client/rest_service.dart';
import '../../domain/input_models/emergencial_contact_input_model.dart';
import '../../infra/datasources/send_update_emergencial_contact_datasource.dart';
import '../mappers/emergencial_contact_input_model_mapper.dart';

class SendUpdateEmergencialContactDatasourceImpl implements SendUpdateEmergencialContactDatasource {
  final RestService _restService;
  final EmergencialContactInputModelMapper _emergencialContactInputModelMapper;

  const SendUpdateEmergencialContactDatasourceImpl({
    required RestService restService,
    required EmergencialContactInputModelMapper emergencialContactInputModelMapper,
  })  : _restService = restService,
        _emergencialContactInputModelMapper = emergencialContactInputModelMapper;

  @override
  Future<void> call({
    required EmergencialContactInputModel emergencialContactInputModel,
    required String emergencialContactId,
  }) async {
    final bodyEmergencialContactInputModel = _emergencialContactInputModelMapper.toMap(
      emergencialContactInputModel: emergencialContactInputModel,
    );

    await _restService.legacyManagementPanelService().put(
          '/emergencial-contact/$emergencialContactId',
          body: bodyEmergencialContactInputModel,
        );
  }
}
