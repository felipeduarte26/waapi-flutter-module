import '../../../../core/types/either.dart';
import '../entities/active_contract_entity.dart';
import '../failures/active_contract_failure.dart';

typedef GetActiveContractUsecaseCallback = Future<Either<ActiveContractFailure, ActiveContractEntity>>;
