import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/share_post_for_members_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../datasources/share_post_for_member_datasource.dart';

class SharePostForMembersRepositoryImpl implements SharePostForMembersRepository {
  final SharePostForMemberDatasource _setPostLikeDatasource;

  const SharePostForMembersRepositoryImpl({
    required SharePostForMemberDatasource setPostLikeDatasource,
  }) : _setPostLikeDatasource = setPostLikeDatasource;

  @override
  SharePostForMembersUsecaseCallback call({
    required String postId,
    required List<String> membersId,
  }) async {
    try {
      for (final memberId in membersId) {
        await _setPostLikeDatasource.call(
          postId: postId,
          memberId: memberId,
        );
      }

      return right(unit);
    } catch (error) {
      return left(SocialDatasourceFailure());
    }
  }
}
