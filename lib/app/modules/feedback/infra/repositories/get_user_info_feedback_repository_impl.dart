import '../../../../core/types/either.dart';
import '../../domain/failures/feedback_failure.dart';
import '../../domain/repositories/get_user_info_feedback_repository.dart';
import '../../domain/types/feedback_domain_types.dart';
import '../adapters/user_info_feedback_entity_adapter.dart';
import '../datasources/get_user_info_feedback_datasource.dart';

class GetUserInfoFeedbackRepositoryImpl implements GetUserInfoFeedbackRepository {
  final GetUserInfoFeedbackDatasource _getUserInfoFeedbackDatasource;
  final UserInfoFeedbackEntityAdapter _userInfoFeedbackEntityAdapter;

  const GetUserInfoFeedbackRepositoryImpl({
    required GetUserInfoFeedbackDatasource getUserInfoFeedbackDatasource,
    required UserInfoFeedbackEntityAdapter userInfoFeedbackEntityAdapter,
  })  : _getUserInfoFeedbackDatasource = getUserInfoFeedbackDatasource,
        _userInfoFeedbackEntityAdapter = userInfoFeedbackEntityAdapter;

  @override
  GetUserInfoFeedbackEntityUsecaseCallback call({
    required String userId,
  }) async {
    try {
      final userInfoFeedbackModel = await _getUserInfoFeedbackDatasource.call(
        userId: userId,
      );

      final userInfoFeedbackEntity = _userInfoFeedbackEntityAdapter.fromModel(
        userInfoFeedbackModel: userInfoFeedbackModel,
      );

      return right(userInfoFeedbackEntity);
    } catch (error) {
      return left(const UserInfoFailure());
    }
  }
}
