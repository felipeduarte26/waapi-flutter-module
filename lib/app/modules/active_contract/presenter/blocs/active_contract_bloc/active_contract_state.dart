import 'package:equatable/equatable.dart';

import '../../../domain/entities/active_contract_entity.dart';

abstract class ActiveContractState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialActiveContractState extends ActiveContractState {}

class LoadingActiveContractState extends ActiveContractState {}

class LoadedActiveContractState extends ActiveContractState {
  final ActiveContractEntity activeContractEntity;

  LoadedActiveContractState({
    required this.activeContractEntity,
  });

  @override
  List<Object?> get props {
    return [
      activeContractEntity,
    ];
  }
}

class NoActiveContractState extends ActiveContractState {}

class ErrorActiveContractState extends ActiveContractState {}
