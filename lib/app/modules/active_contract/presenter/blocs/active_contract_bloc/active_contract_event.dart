import 'package:equatable/equatable.dart';

abstract class ActiveContractEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class GetActiveContractEvent extends ActiveContractEvent {}
