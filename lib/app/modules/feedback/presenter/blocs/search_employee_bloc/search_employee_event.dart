import 'package:equatable/equatable.dart';

import '../../../domain/entities/employee_entity.dart';

abstract class SearchEmployeeEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class SearchEmployeeToWriteFeedbackEvent extends SearchEmployeeEvent {
  final String search;

  SearchEmployeeToWriteFeedbackEvent({
    required this.search,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      search,
    ];
  }
}

class SelectEmployeeFromEntityToWriteFeedbackEvent extends SearchEmployeeEvent {
  final EmployeeEntity employeeEntity;

  SelectEmployeeFromEntityToWriteFeedbackEvent({
    required this.employeeEntity,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      employeeEntity,
    ];
  }
}

class UnselectEmployeeFeedbackEvent extends SearchEmployeeEvent {}

class ClearSearchEmployeeFeedbackEvent extends SearchEmployeeEvent {}
