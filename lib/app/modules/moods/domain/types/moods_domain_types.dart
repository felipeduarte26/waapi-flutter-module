import '../../../../core/types/either.dart';
import '../failures/moods_failure.dart';

typedef GetMoodsPulseLinkUsecaseCallback = Future<Either<MoodsFailure, String>>;
