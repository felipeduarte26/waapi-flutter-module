import '../../../../core/types/either.dart';
import '../failures/feedback_failure.dart';
import '../repositories/get_user_info_feedback_repository.dart';
import '../types/feedback_domain_types.dart';

abstract class GetUserInfoFeedbackUsecase {
  GetUserInfoFeedbackEntityUsecaseCallback call({
    required String userId,
  });
}

class GetUserInfoFeedbackUsecaseImpl implements GetUserInfoFeedbackUsecase {
  final GetUserInfoFeedbackRepository _getUserInfoFeedbackRepository;

  const GetUserInfoFeedbackUsecaseImpl({
    required GetUserInfoFeedbackRepository getUserInfoFeedbackRepository,
  }) : _getUserInfoFeedbackRepository = getUserInfoFeedbackRepository;

  @override
  GetUserInfoFeedbackEntityUsecaseCallback call({
    required String userId,
  }) async {
    if (userId.isEmpty) {
      return left(const UserInfoFailure());
    }

    return _getUserInfoFeedbackRepository.call(
      userId: userId,
    );
  }
}
