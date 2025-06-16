import '../../../../core/types/either.dart';
import '../entities/authorization_entity.dart';
import '../failures/authorization_failure.dart';

typedef GetUserAuthorizationsUsecaseCallback = Future<Either<AuthorizationFailure, AuthorizationEntity>>;
