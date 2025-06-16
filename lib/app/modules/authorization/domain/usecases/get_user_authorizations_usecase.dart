import '../repositories/authorization_repository.dart';
import '../types/authorization_domain_types.dart';

abstract class GetUserAuthorizationsUsecase {
  GetUserAuthorizationsUsecaseCallback call();
}

class GetUserAuthorizationsUsecaseImpl implements GetUserAuthorizationsUsecase {
  final AuthorizationRepository _authorizationRepository;

  const GetUserAuthorizationsUsecaseImpl({
    required AuthorizationRepository authorizationRepository,
  }) : _authorizationRepository = authorizationRepository;

  @override
  GetUserAuthorizationsUsecaseCallback call() {
    return _authorizationRepository.call();
  }
}
