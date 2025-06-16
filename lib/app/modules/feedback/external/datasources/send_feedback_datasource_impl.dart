import '../../../../core/services/rest_client/rest_service.dart';
import '../../domain/input_models/send_feedback_input_model.dart';
import '../../infra/datasources/send_feedback_datasource.dart';
import '../../infra/models/send_feedback_id_model.dart';
import '../mappers/send_feedback_id_model_mapper.dart';
import '../mappers/send_feedback_input_model_mapper.dart';

class SendFeedbackDatasourceImpl implements SendFeedbackDatasource {
  final RestService _restService;
  final SendFeedbackIdModelMapper _sentFeedbackIdModelMapper;
  final SendFeedbackInputModelMapper _sendFeedbackInputModelMapper;

  const SendFeedbackDatasourceImpl({
    required RestService restService,
    required SendFeedbackIdModelMapper sentFeedbackIdModelMapper,
    required SendFeedbackInputModelMapper sendFeedbackInputModelMapper,
  })  : _restService = restService,
        _sentFeedbackIdModelMapper = sentFeedbackIdModelMapper,
        _sendFeedbackInputModelMapper = sendFeedbackInputModelMapper;

  @override
  Future<SendFeedbackIdModel> call({
    required SendFeedbackInputModel sendFeedbackInputModel,
  }) async {
    final bodyRequest = _sendFeedbackInputModelMapper.toMap(
      sendFeedbackInputModel: sendFeedbackInputModel,
    );

    final sendFeedbackResult = await _restService.legacyManagementPanelService().post(
          '/feedback',
          body: bodyRequest,
        );

    return _sentFeedbackIdModelMapper.fromJson(
      sentFeedbackIdJson: sendFeedbackResult.data ?? '{}',
    );
  }
}
