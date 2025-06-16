import '../../../../core/pagination/pagination_requirements.dart';
import '../repositories/get_spaces_repository.dart';
import '../types/social_domain_types.dart';

abstract class GetSpacesUsecase {
  GetSpacesUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
  });
}

class GetSpacesUsecaseImpl implements GetSpacesUsecase {
  final GetSpacesRepository _getSpacesRepository;

  GetSpacesUsecaseImpl({
    required GetSpacesRepository getSpacesRepository,
  }) : _getSpacesRepository = getSpacesRepository;

  @override
  GetSpacesUsecaseCallback call({required PaginationRequirements paginationRequirements}) {
    return _getSpacesRepository.call(
      paginationRequirements: paginationRequirements,
    );
  }
}
