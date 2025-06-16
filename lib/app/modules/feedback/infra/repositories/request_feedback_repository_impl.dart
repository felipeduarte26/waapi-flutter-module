import '../../../../core/types/either.dart';
import '../../domain/failures/feedback_failure.dart';
import '../../domain/input_models/request_feedback_input_model.dart';
import '../../domain/repositories/request_feedback_repository.dart';
import '../../domain/types/feedback_domain_types.dart';
import '../datasources/request_feedback_datasource.dart';

class RequestFeedbackRepositoryImpl implements RequestFeedbackRepository {
  final RequestFeedbackDatasource _requestFeedbackDatasource;

  const RequestFeedbackRepositoryImpl({
    required RequestFeedbackDatasource requestFeedbackDatasource,
  }) : _requestFeedbackDatasource = requestFeedbackDatasource;

  @override
  RequestFeedbackUsecaseCallback call({
    required RequestFeedbackInputModel requestFeedbackInputModel,
  }) async {
    try {
      await _requestFeedbackDatasource.call(
        requestFeedbackInputModel: requestFeedbackInputModel,
      );
      return right(unit);
    } catch (error) {
      return left(const FeedbackDatasourceFailure());
    }
  }
}
