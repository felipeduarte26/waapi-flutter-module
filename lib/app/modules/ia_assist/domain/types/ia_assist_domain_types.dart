import '../../../../core/types/either.dart';
import '../failures/ia_assist_failure.dart';

typedef IAAssistUsecaseCallback = Future<Either<IAAssistFailure, String>>;
