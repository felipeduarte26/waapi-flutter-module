part of 'payroll_screen_bloc.dart';

abstract class PayrollScreenState extends Equatable {
  final PayrollState payrollState;
  final PersonalizationState personalizationState;
  final ProfileState profileState;
  final ContractEmployeeState contractEmployeeState;

  const PayrollScreenState({
    required this.payrollState,
    required this.personalizationState,
    required this.profileState,
    required this.contractEmployeeState,
  });

  CurrentPayrollScreenState currentState({
    PayrollState? payrollState,
    PersonalizationState? personalizationState,
    ProfileState? profileState,
    ContractEmployeeState? contractEmployeeState,
  }) {
    return CurrentPayrollScreenState(
      payrollState: payrollState ?? this.payrollState,
      personalizationState: personalizationState ?? this.personalizationState,
      profileState: profileState ?? this.profileState,
      contractEmployeeState: contractEmployeeState ?? this.contractEmployeeState,
    );
  }

  @override
  List<Object> get props => [
        payrollState,
        personalizationState,
        profileState,
        contractEmployeeState,
      ];
}

class CurrentPayrollScreenState extends PayrollScreenState {
  const CurrentPayrollScreenState({
    required PayrollState payrollState,
    required PersonalizationState personalizationState,
    required ProfileState profileState,
    required ContractEmployeeState contractEmployeeState,
  }) : super(
          payrollState: payrollState,
          personalizationState: personalizationState,
          profileState: profileState,
          contractEmployeeState: contractEmployeeState,
        );
}
