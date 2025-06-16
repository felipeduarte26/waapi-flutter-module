import '../../../../core/types/either.dart';
import '../../domain/failures/feedback_failure.dart';
import '../../domain/repositories/delete_feedback_repository.dart';
import '../../domain/types/feedback_domain_types.dart';
import '../datasources/delete_feedback_datasource.dart';

class DeleteFeedbackRepositoryImpl implements DeleteFeedbackRepository {
  final DeleteFeedbackDatasource _deleteFeedbackDatasource;

  const DeleteFeedbackRepositoryImpl({
    required DeleteFeedbackDatasource deleteFeedbackDatasource,
  }) : _deleteFeedbackDatasource = deleteFeedbackDatasource;

  @override
  DeleteFeedbackUsecaseCallback call({
    required String idFeedback,
  }) async {
    try {
      await _deleteFeedbackDatasource.call(
        idFeedback: idFeedback,
      );
      return right(unit);
    } catch (error) {
      return left(const FeedbackDatasourceFailure());
    }
  }
}
