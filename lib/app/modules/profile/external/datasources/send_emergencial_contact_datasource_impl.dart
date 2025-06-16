import 'dart:async';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../domain/input_models/emergencial_contact_input_model.dart';
import '../../infra/datasources/send_emergencial_contact_datasource.dart';
import '../mappers/emergencial_contact_input_model_mapper.dart';

class SendEmergencialContactDatasourceImpl implements SendEmergencialContactDatasource {
  final RestService _restService;
  final EmergencialContactInputModelMapper _emergencialContactInputModelMapper;

  const SendEmergencialContactDatasourceImpl({
    required RestService restService,
    required EmergencialContactInputModelMapper emergencialContactInputModelMapper,
  })  : _restService = restService,
        _emergencialContactInputModelMapper = emergencialContactInputModelMapper;

  @override
  Future<void> call({
    required EmergencialContactInputModel emergencialContactUploadedInputModel,
  }) async {
    final bodyEmergencialContactUploadedInputModel = _emergencialContactInputModelMapper.toMap(
      emergencialContactInputModel: emergencialContactUploadedInputModel,
    );

    await _restService.legacyManagementPanelService().post(
          '/emergencial-contact',
          body: bodyEmergencialContactUploadedInputModel,
        );
  }
}
