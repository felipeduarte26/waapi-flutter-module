import '../../../../core/types/either.dart';
import '../../domain/entities/authorization_entity.dart';
import '../../domain/failures/authorization_failure.dart';

typedef GetUserAuthorizationRepositoryCallback = Future<Either<AuthorizationFailure, AuthorizationEntity>>;
