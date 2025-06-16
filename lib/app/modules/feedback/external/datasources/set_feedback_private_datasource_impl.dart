import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/set_feedback_private_datasource.dart';

class SetFeedbackPrivateDatasourceImpl implements SetFeedbackPrivateDatasource {
  final RestService _restService;

  const SetFeedbackPrivateDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<void> call({
    required String idFeedback,
  }) async {
    final setFeedbackAsPrivatePath = '/feedback/$idFeedback/private';
    await _restService.legacyManagementPanelService().put(setFeedbackAsPrivatePath);
  }
}
