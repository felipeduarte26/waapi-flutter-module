import '../repositories/get_hyperlinks_repository.dart';
import '../types/hyperlink_domain_types.dart';

abstract class GetHyperlinksUsecase {
  GetHyperlinksUsecaseCallback call({
    required String employeeId,
    required String userRoleId,
  });
}

class GetHyperlinksUsecaseImpl implements GetHyperlinksUsecase {
  final GetHyperlinksRepository _getHyperlinksRepository;

  const GetHyperlinksUsecaseImpl({
    required GetHyperlinksRepository getHyperlinksRepository,
  }) : _getHyperlinksRepository = getHyperlinksRepository;

  @override
  GetHyperlinksUsecaseCallback call({
    required String employeeId,
    required String userRoleId,
  }) {
    return _getHyperlinksRepository.call(
      employeeId: employeeId,
      userRoleId: userRoleId,
    );
  }
}
