import '../../../../types/either.dart';
import '../failures/has_clocking_failure.dart';

typedef GetHasClockingCallback = Future<Either<HasClockingFailure, bool>>;
typedef SaveHasClockingCallback = Future<Either<HasClockingFailure, Unit>>;
