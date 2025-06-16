import '../../../../core/types/either.dart';
import '../../domain/failures/feedback_failure.dart';
import '../../domain/repositories/set_feedback_public_repository.dart';
import '../../domain/types/feedback_domain_types.dart';
import '../datasources/set_feedback_public_datasource.dart';

class SetFeedbackPublicRepositoryImpl implements SetFeedbackPublicRepository {
  final SetFeedbackPublicDatasource _setFeedbackPublicDatasource;

  const SetFeedbackPublicRepositoryImpl({
    required SetFeedbackPublicDatasource setFeedbackPublicDatasource,
  }) : _setFeedbackPublicDatasource = setFeedbackPublicDatasource;

  @override
  SetFeedbackPublicUsecaseCallback call({
    required String idFeedback,
  }) async {
    try {
      await _setFeedbackPublicDatasource.call(
        idFeedback: idFeedback,
      );

      return right(unit);
    } catch (error) {
      return left(const FeedbackDatasourceFailure());
    }
  }
}
