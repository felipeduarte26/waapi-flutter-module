import '../../../../core/pagination/pagination_requirements.dart';
import '../repositories/get_members_repository.dart';
import '../types/social_domain_types.dart';

abstract class GetMembersUsecase {
  GetMembersUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
  });
}

class GetMembersUsecaseImpl implements GetMembersUsecase {
  final GetMembersRepository _getMembersRepository;

  const GetMembersUsecaseImpl({
    required GetMembersRepository getMembersRepository,
  }) : _getMembersRepository = getMembersRepository;

  @override
  GetMembersUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
  }) async {
    return _getMembersRepository.call(
      paginationRequirements: paginationRequirements,
    );
  }
}
