import '../../../../core/types/either.dart';
import '../entities/personalization_entity.dart';
import '../entities/personalization_mobile_entity.dart';
import '../failures/personalization_failure.dart';

typedef GetPersonalizationUsecaseCallback = Future<Either<PersonalizationFailure, PersonalizationEntity>>;
typedef GetPersonalizationMobileUsecaseCallback = Future<Either<PersonalizationMobileDatasourceFailure, PersonalizationMobileEntity>>;
typedef CleanPersonalizationMobileDriverCallback = Future<Either<PersonalizationMobileDatasourceFailure, Unit>>;
