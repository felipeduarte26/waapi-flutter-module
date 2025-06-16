import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/set_feedback_public_datasource.dart';

class SetFeedbackPublicDatasourceImpl implements SetFeedbackPublicDatasource {
  final RestService _restService;

  const SetFeedbackPublicDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<void> call({
    required String idFeedback,
  }) async {
    final setFeedbackAsPublicPath = '/feedback/$idFeedback/public';
    await _restService.legacyManagementPanelService().put(setFeedbackAsPublicPath);
  }
}
