import '../repositories/share_post_for_members_repository.dart';
import '../types/social_domain_types.dart';

abstract class SharePostForMembersUsecase {
  SharePostForMembersUsecaseCallback call({
    required String postId,
    required List<String> membersId,
  });
}

class SharePostForMembersUsecaseImpl implements SharePostForMembersUsecase {
  final SharePostForMembersRepository _sharePostForMemberRepository;

  SharePostForMembersUsecaseImpl({
    required SharePostForMembersRepository sharePostForMemberRepository,
  }) : _sharePostForMemberRepository = sharePostForMemberRepository;

  @override
  SharePostForMembersUsecaseCallback call({
    required String postId,
    required List<String> membersId,
  }) {
    return _sharePostForMemberRepository.call(
      postId: postId,
      membersId: membersId,
    );
  }
}
