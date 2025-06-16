import '../../../../core/types/either.dart';
import '../failures/g5_failure.dart';

typedef GetG5ConnectorUsecaseCallback = Future<Either<G5Failure, String>>;
