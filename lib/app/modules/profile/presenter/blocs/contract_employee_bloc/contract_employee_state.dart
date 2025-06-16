import 'package:equatable/equatable.dart';

import '../../../domain/entities/contract_employee_entity.dart';

abstract class ContractEmployeeState extends Equatable {
  final ContractEmployeeEntity? contractEmployeeEntity;

  const ContractEmployeeState({
    required this.contractEmployeeEntity,
  });

  LoadingContractEmployeeState loadingContractEmployeeState() {
    return LoadingContractEmployeeState(
      contractEmployeeEntity: contractEmployeeEntity,
    );
  }

  LoadedContractEmployeeState loadedContractEmployeeState({
    required ContractEmployeeEntity contractEmployeeEntity,
  }) {
    return LoadedContractEmployeeState(
      contractEmployeeEntity: contractEmployeeEntity,
    );
  }

  ErrorContractEmployeeState errorContractEmployeeState() {
    return ErrorContractEmployeeState(
      contractEmployeeEntity: contractEmployeeEntity,
    );
  }

  ErrorUpdateContractEmployeeState errorUpdateContractEmployeeState() {
    return ErrorUpdateContractEmployeeState(
      contractEmployeeEntity: contractEmployeeEntity,
    );
  }

  @override
  List<Object?> get props {
    return [
      contractEmployeeEntity,
    ];
  }
}

class InitialContractEmployeeState extends ContractEmployeeState {
  const InitialContractEmployeeState({
    ContractEmployeeEntity? contractEmployeeEntity,
  }) : super(contractEmployeeEntity: contractEmployeeEntity);
}

class LoadingContractEmployeeState extends ContractEmployeeState {
  const LoadingContractEmployeeState({
    ContractEmployeeEntity? contractEmployeeEntity,
  }) : super(contractEmployeeEntity: contractEmployeeEntity);
}

class LoadedContractEmployeeState extends ContractEmployeeState {
  const LoadedContractEmployeeState({
    required ContractEmployeeEntity contractEmployeeEntity,
  }) : super(contractEmployeeEntity: contractEmployeeEntity);
}

class ErrorContractEmployeeState extends ContractEmployeeState {
  const ErrorContractEmployeeState({
    ContractEmployeeEntity? contractEmployeeEntity,
  }) : super(contractEmployeeEntity: contractEmployeeEntity);
}

class ErrorUpdateContractEmployeeState extends ContractEmployeeState {
  const ErrorUpdateContractEmployeeState({
    ContractEmployeeEntity? contractEmployeeEntity,
  }) : super(contractEmployeeEntity: contractEmployeeEntity);
}
