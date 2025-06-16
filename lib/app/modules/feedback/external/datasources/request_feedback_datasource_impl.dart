import '../../../../core/services/rest_client/rest_service.dart';
import '../../domain/input_models/request_feedback_input_model.dart';
import '../../infra/datasources/request_feedback_datasource.dart';
import '../mappers/request_feedback_input_model_mapper.dart';

class RequestFeedbackDatasourceImpl implements RequestFeedbackDatasource {
  final RestService _restService;
  final RequestFeedbackInputModelMapper _sendFeedbackInputModelMapper;

  const RequestFeedbackDatasourceImpl({
    required RestService restService,
    required RequestFeedbackInputModelMapper requestFeedbackInputModelMapper,
  })  : _restService = restService,
        _sendFeedbackInputModelMapper = requestFeedbackInputModelMapper;

  @override
  Future<void> call({
    required RequestFeedbackInputModel requestFeedbackInputModel,
  }) async {
    final bodyRequestFeedbackInputModel = _sendFeedbackInputModelMapper.toMap(
      requestFeedbackInputModel: requestFeedbackInputModel,
    );

    await _restService.legacyManagementPanelService().post(
          '/feedback/request',
          body: bodyRequestFeedbackInputModel,
        );
  }
}
