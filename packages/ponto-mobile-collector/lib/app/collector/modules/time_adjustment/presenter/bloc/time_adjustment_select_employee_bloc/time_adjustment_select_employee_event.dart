abstract class TimeAdjustmentSelectEmployeeEvent {}

class TimeAdjustmentSelectEmployeeSearchInProgress
    implements TimeAdjustmentSelectEmployeeEvent {}

class TimeAdjustmentSelectedEmployee
    implements TimeAdjustmentSelectEmployeeEvent {
  final String employeeId;

  TimeAdjustmentSelectedEmployee({required this.employeeId});
}

class TimeAdjustmentSelectEmployeeSearch
    extends TimeAdjustmentSelectEmployeeEvent {
}

class TimeAdjustmentSelectEmployeeSearching
    extends TimeAdjustmentSelectEmployeeEvent {
  final String employeeNameSearch;

  TimeAdjustmentSelectEmployeeSearching({required this.employeeNameSearch});
}

class TimeAdjustmentSelectEmployeeSearchClean
    extends TimeAdjustmentSelectEmployeeEvent {}

class TimeAdjustmentSelectEmployeeLoadMore
    implements TimeAdjustmentSelectEmployeeEvent {}
