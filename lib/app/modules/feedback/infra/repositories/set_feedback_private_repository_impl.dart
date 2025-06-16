import '../../../../core/types/either.dart';
import '../../domain/failures/feedback_failure.dart';
import '../../domain/repositories/set_feedback_private_repository.dart';
import '../../domain/types/feedback_domain_types.dart';
import '../datasources/set_feedback_private_datasource.dart';

class SetFeedbackPrivateRepositoryImpl implements SetFeedbackPrivateRepository {
  final SetFeedbackPrivateDatasource _setFeedbackPrivateDatasource;

  const SetFeedbackPrivateRepositoryImpl({
    required SetFeedbackPrivateDatasource setFeedbackPrivateDatasource,
  }) : _setFeedbackPrivateDatasource = setFeedbackPrivateDatasource;

  @override
  SetFeedbackPrivateUsecaseCallback call({
    required String idFeedback,
  }) async {
    try {
      await _setFeedbackPrivateDatasource.call(
        idFeedback: idFeedback,
      );

      return right(unit);
    } catch (error) {
      return left(const FeedbackDatasourceFailure());
    }
  }
}
