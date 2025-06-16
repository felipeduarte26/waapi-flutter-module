import 'package:equatable/equatable.dart';

import '../../../../../core/pagination/pagination_requirements.dart';

abstract class BirthdayEmployeesEvent extends Equatable {
  const BirthdayEmployeesEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class GetNext15DaysBirthdayEmployeesEvent extends BirthdayEmployeesEvent {
  final PaginationRequirements paginationRequirements;
  final DateTime currentDate;
  final String employeeId;

  const GetNext15DaysBirthdayEmployeesEvent({
    required this.paginationRequirements,
    required this.currentDate,
    required this.employeeId,
  });

  @override
  List<Object> get props {
    return [
      ...super.props,
      paginationRequirements,
      currentDate,
    ];
  }
}

class ReloadNext15DaysBirthdayEmployeesEvent extends BirthdayEmployeesEvent {
  const ReloadNext15DaysBirthdayEmployeesEvent();

  @override
  List<Object> get props {
    return [
      ...super.props,
    ];
  }
}
