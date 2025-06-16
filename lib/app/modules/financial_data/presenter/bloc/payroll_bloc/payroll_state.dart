import 'package:equatable/equatable.dart';

import '../../../domain/entities/payroll_entity.dart';

abstract class PayrollState extends Equatable {
  final Set<PayrollEntity> payroll;
  final PayrollEntity payrollEntitySelected;

  const PayrollState({
    this.payroll = const <PayrollEntity>{},
    this.payrollEntitySelected = const PayrollEntity(),
  });

  LoadingPayrollState loadingPayrollState() {
    return const LoadingPayrollState();
  }

  LoadingMorePayrollgState loadingMorePayrollState() {
    return LoadingMorePayrollgState(
      payroll: payroll,
    );
  }

  EmptyListPayrollState emptyListPayrollState() {
    return EmptyListPayrollState();
  }

  LoadedPayrollState loadedPayrollState({
    required Set<PayrollEntity> payroll,
  }) {
    return LoadedPayrollState(
      payroll: payroll,
    );
  }

  LoadedPayrollSelectedState loadedPayrollSelectedState({
    required PayrollEntity payrollEntitySelected,
  }) {
    return LoadedPayrollSelectedState(
      payrollEntitySelected: payrollEntitySelected,
    );
  }

  LastPagePayrollState lastPagePayrollState({
    required Set<PayrollEntity> payroll,
  }) {
    return LastPagePayrollState(
      payroll: payroll,
    );
  }

  ErrorPayrollState errorPayrollState({
    String? errorMessage,
  }) {
    return ErrorPayrollState(
      message: errorMessage!,
      payroll: payroll,
    );
  }

  @override
  List<Object?> get props => [
        payroll,
        payrollEntitySelected,
      ];
}

class InitialPayrollState extends PayrollState {
  const InitialPayrollState() : super();
}

class LoadingPayrollState extends PayrollState {
  const LoadingPayrollState() : super();
}

class LoadingMorePayrollgState extends PayrollState {
  const LoadingMorePayrollgState({
    required Set<PayrollEntity> payroll,
  }) : super(payroll: payroll);
}

class LoadedPayrollState extends PayrollState {
  const LoadedPayrollState({
    required Set<PayrollEntity> payroll,
  }) : super(payroll: payroll);
}

class LoadedPayrollSelectedState extends PayrollState {
  const LoadedPayrollSelectedState({
    required PayrollEntity payrollEntitySelected,
  }) : super(payrollEntitySelected: payrollEntitySelected);
}

class EmptyListPayrollState extends PayrollState {}

class LastPagePayrollState extends PayrollState {
  const LastPagePayrollState({
    required Set<PayrollEntity> payroll,
  }) : super(payroll: payroll);
}

class ErrorPayrollState extends PayrollState {
  final String? message;
  const ErrorPayrollState({
    this.message,
    required Set<PayrollEntity> payroll,
  }) : super(payroll: payroll);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
    ];
  }
}
