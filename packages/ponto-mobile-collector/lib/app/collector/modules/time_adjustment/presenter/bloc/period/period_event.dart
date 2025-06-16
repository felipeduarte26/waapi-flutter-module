abstract class PeriodEvent {}

class LoadingClockingEventEvent extends PeriodEvent {
  final DateTime initDate;
  final DateTime endDate;
  final String username;

  LoadingClockingEventEvent({
    required this.initDate,
    required this.endDate,
    required this.username,
  });
}

class TodayPeriodEvent extends PeriodEvent {}

class BackWeekPeriodEvent extends PeriodEvent {}

class AheadWeekPeriodEvent extends PeriodEvent {}

class RefreshPeriodEvent extends PeriodEvent {}

class FilterPeriodEvent extends PeriodEvent {
  final DateTime initDate;
  final DateTime endDate;
  final bool isPeriodSelected;

  FilterPeriodEvent({
    required this.initDate,
    required this.endDate,
    required this.isPeriodSelected,
  });
}

class FilterEmployeeEvent extends PeriodEvent {
  final List<String>? employeesIds;
  final bool isEmployeesSelected;

  FilterEmployeeEvent({
    required this.employeesIds,
    required this.isEmployeesSelected,
  });
}

class LoadPeriodEvent extends PeriodEvent {}
