import '../../../../core/types/either.dart';
import '../entities/happiness_index_group_entity.dart';
import '../entities/happiness_index_mood_entity.dart';
import '../failures/happiness_index_failure.dart';

typedef GetCurrentHappinessIndexUsecaseCallback = Future<Either<HappinessIndexFailure, HappinessIndexMoodEntity>>;
typedef SaveHappinessIndexUsecaseCallback = Future<Either<HappinessIndexFailure, Unit>>;
typedef HappinessIndexIsEnabledUsecaseCallback = Future<Either<HappinessIndexFailure, bool>>;
typedef GetMoodRecordsUsecaseCallback = Future<Either<HappinessIndexFailure, List<HappinessIndexMoodEntity>>>;

typedef RetrieveAllReasonsHappinessIndexUsecaseCallback
    = Future<Either<HappinessIndexFailure, List<HappinessIndexGroupEntity>>>;
