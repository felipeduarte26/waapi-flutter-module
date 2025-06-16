part of 'payroll_screen_bloc.dart';

abstract class PayrollScreenEvent extends Equatable {}

class ChangePayrollStateEvent extends PayrollScreenEvent {
  final PayrollState payrollState;

  ChangePayrollStateEvent({
    required this.payrollState,
  });

  @override
  List<Object?> get props => [
        payrollState,
      ];
}

class ChangePersonalizationStateEvent extends PayrollScreenEvent {
  final PersonalizationState personalizationState;

  ChangePersonalizationStateEvent({
    required this.personalizationState,
  });

  @override
  List<Object?> get props => [
        personalizationState,
      ];
}

class ChangeProfileStateEvent extends PayrollScreenEvent {
  final ProfileState profileState;

  ChangeProfileStateEvent({
    required this.profileState,
  });

  @override
  List<Object?> get props => [
        profileState,
      ];
}

class ChangeContractEmployeeStateEvent extends PayrollScreenEvent {
  final ContractEmployeeState contractEmployeeState;

  ChangeContractEmployeeStateEvent({
    required this.contractEmployeeState,
  });

  @override
  List<Object?> get props => [
        contractEmployeeState,
      ];
}
