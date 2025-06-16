import '../types/authorization_domain_types.dart';

abstract class AuthorizationRepository {
  GetUserAuthorizationsUsecaseCallback call();
}
