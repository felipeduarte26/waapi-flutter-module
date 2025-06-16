import '../repositories/get_space_info_repository.dart';
import '../types/social_domain_types.dart';

abstract class GetSpaceInfoUsecase {
  GetSpaceInfoUsecaseCallback call({
    required String permaname,
  });
}

class GetSpaceInfoUsecaseImpl implements GetSpaceInfoUsecase {
  final GetSpaceInfoRepository _getSpaceInfoRepository;

  const GetSpaceInfoUsecaseImpl({
    required GetSpaceInfoRepository getSpaceInfoRepository,
  }) : _getSpaceInfoRepository = getSpaceInfoRepository;

  @override
  GetSpaceInfoUsecaseCallback call({
    required String permaname,
  }) {
    return _getSpaceInfoRepository.call(
      permaname: permaname,
    );
  }
}
