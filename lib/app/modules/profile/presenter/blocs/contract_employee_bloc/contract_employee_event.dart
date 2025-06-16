import 'package:equatable/equatable.dart';

abstract class ContractEmployeeEvent extends Equatable {
  const ContractEmployeeEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class GetContractEmployeeEvent extends ContractEmployeeEvent {
  final String employeeId;

  const GetContractEmployeeEvent({
    required this.employeeId,
  });

  @override
  List<Object> get props {
    return [
      ...super.props,
      employeeId,
    ];
  }
}
