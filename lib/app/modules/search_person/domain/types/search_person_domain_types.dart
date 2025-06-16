import '../../../../core/types/either.dart';
import '../entities/person_entity.dart';
import '../failures/search_person_failure.dart';

typedef SearchPersonByTermUsecaseCallback = Future<Either<SearchPersonFailure, List<PersonEntity>>>;
