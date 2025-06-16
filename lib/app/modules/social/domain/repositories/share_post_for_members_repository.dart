import '../types/social_domain_types.dart';

abstract class SharePostForMembersRepository {
  SharePostForMembersUsecaseCallback call({
    required String postId,
    required List<String> membersId,
  });
}
