import '../../../../core/pagination/pagination_requirements.dart';

import '../../../../core/types/either.dart';
import '../../../feedback/infra/adapters/feedback_entity_adapter.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/get_public_feedbacks_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../datasources/get_public_feedbacks_datasource.dart';

class GetPublicFeedbacksRepositoryImpl implements GetPublicFeedbacksRepository {
  final GetPublicFeedbacksDatasource _getPublicFeedbacksDatasource;
  final FeedbackEntityAdapter _feedbackEntityAdapter;

  GetPublicFeedbacksRepositoryImpl({
    required GetPublicFeedbacksDatasource getPublicFeedbacksDatasource,
    required FeedbackEntityAdapter feedbackEntityAdapter,
  })  : _getPublicFeedbacksDatasource = getPublicFeedbacksDatasource,
        _feedbackEntityAdapter = feedbackEntityAdapter;

  @override
  GetPublicFeedbacksUsecaseCallback call({
    required String employeeId,
    required PaginationRequirements paginationRequirements,
  }) async {
    try {
      final feedbacksModel = await _getPublicFeedbacksDatasource.call(
        employeeId: employeeId,
        paginationRequirements: paginationRequirements,
      );

      final feedbacksEntity = feedbacksModel.map(
        (feedbackModel) {
          return _feedbackEntityAdapter.fromModel(
            feedbackModel: feedbackModel,
          );
        },
      ).toList();

      return right(feedbacksEntity);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
