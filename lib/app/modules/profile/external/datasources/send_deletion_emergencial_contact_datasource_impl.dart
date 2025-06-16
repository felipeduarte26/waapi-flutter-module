import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/send_deletion_emergencial_contact_datasource.dart';

class SendDeletionEmergencialContactDatasourceImpl implements SendDeletionEmergencialContactDatasource {
  final RestService _restService;

  const SendDeletionEmergencialContactDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<void> call({
    required String idEmergencialContact,
  }) async {
    await _restService.legacyManagementPanelService().delete('/emergencial-contact/$idEmergencialContact');
  }
}
