import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/delete_feedback_datasource.dart';

class DeleteFeedbackDatasourceImpl implements DeleteFeedbackDatasource {
  final RestService _restService;

  const DeleteFeedbackDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<void> call({
    required String idFeedback,
  }) async {
    final deleteFeedbackPath = '/feedback/$idFeedback';
    await _restService.legacyManagementPanelService().delete(deleteFeedbackPath);
  }
}
