import '../../../../core/types/either.dart';
import '../../domain/failures/feedback_failure.dart';
import '../../domain/input_models/send_feedback_input_model.dart';
import '../../domain/repositories/send_feedback_repository.dart';
import '../../domain/types/feedback_domain_types.dart';
import '../../enums/feedback_analytics_type_enum.dart';
import '../adapters/sent_feedback_id_entity_adapter.dart';
import '../datasources/send_feedback_datasource.dart';

class SendFeedbackRepositoryImpl implements SendFeedbackRepository {
  final SendFeedbackDatasource _sendFeedbackDatasource;
  final SentFeedbackIdEntityAdapter _sentFeedbackIdEntityAdapter;

  const SendFeedbackRepositoryImpl({
    required SendFeedbackDatasource sendFeedbackDatasource,
    required SentFeedbackIdEntityAdapter sentFeedbackIdEntityAdapter,
  })  : _sendFeedbackDatasource = sendFeedbackDatasource,
        _sentFeedbackIdEntityAdapter = sentFeedbackIdEntityAdapter;

  @override
  SendFeedbackUsecaseCallback call({
    required SendFeedbackInputModel sendFeedbackInputModel,
    required FeedbackAnalyticsTypeEnum feedbackAnalyticsTypeEnum,
  }) async {
    try {
      final sendFeedbackIdModelResult = await _sendFeedbackDatasource.call(
        sendFeedbackInputModel: sendFeedbackInputModel,
      );

      final sentFeedbackIdEntity = _sentFeedbackIdEntityAdapter.fromModel(
        sentFeedbackIdModel: sendFeedbackIdModelResult,
      );

      return right(sentFeedbackIdEntity);
    } catch (error) {
      return left(const FeedbackDatasourceFailure());
    }
  }
}
