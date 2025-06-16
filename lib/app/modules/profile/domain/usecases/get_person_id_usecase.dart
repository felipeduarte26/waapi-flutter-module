import '../repositories/get_person_id_repository.dart';
import '../types/profile_domain_types.dart';

abstract class GetPersonIdUsecase {
  GetPersonIdUsecaseCallback call({
    required String employeeId,
  });
}

class GetPersonIdUsecaseImpl implements GetPersonIdUsecase {
  final GetPersonIdRepository _getPersonIdRepository;

  const GetPersonIdUsecaseImpl({
    required GetPersonIdRepository getPersonIdRepository,
  }) : _getPersonIdRepository = getPersonIdRepository;

  @override
  GetPersonIdUsecaseCallback call({
    required String employeeId,
  }) {
    return _getPersonIdRepository.call(
      employeeId: employeeId,
    );
  }
}
