import '../../../../core/pagination/pagination_requirements.dart';
import '../repositories/get_social_member_spaces_repository.dart';
import '../types/social_domain_types.dart';

abstract class GetSocialMembersSpaceUsecase {
  GetSocialMemberSpacesUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
  });
}

class GetSocialMembersSpaceUsecaseImpl implements GetSocialMembersSpaceUsecase {
  final GetSocialMemberSpacesRepository _getMembersSpaceRepository;

  const GetSocialMembersSpaceUsecaseImpl({
    required GetSocialMemberSpacesRepository getMembersSpaceRepository,
  }) : _getMembersSpaceRepository = getMembersSpaceRepository;

  @override
  GetSocialMemberSpacesUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
  }) async {
    return _getMembersSpaceRepository.call(
      paginationRequirements: paginationRequirements,
    );
  }
}
