import 'package:equatable/equatable.dart';

import '../../../../../core/pagination/pagination_requirements.dart';
import '../../../domain/entities/payroll_entity.dart';

abstract class PayrollEvent extends Equatable {}

class GetPayrollListEvent extends PayrollEvent {
  final String employeerId;
  final PaginationRequirements paginationRequirements;
  final bool overrideNotAllowedStates;

  GetPayrollListEvent({
    required this.employeerId,
    required this.paginationRequirements,
    this.overrideNotAllowedStates = false,
  });

  @override
  List<Object?> get props => [
        employeerId,
        paginationRequirements,
        overrideNotAllowedStates,
      ];
}

class GetPayrollEntityEvent extends PayrollEvent {
  final PayrollEntity payroll;

  GetPayrollEntityEvent({
    required this.payroll,
  });

  @override
  List<Object?> get props => [
        payroll,
      ];
}
