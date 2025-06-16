abstract class FilterEmployeeSelectEvent {}

class FilterEmployeeSearchEvent extends FilterEmployeeSelectEvent {
  final int page;

  FilterEmployeeSearchEvent({
    required this.page,
  });
}

class FilterEmployeeInitEvent extends FilterEmployeeSelectEvent {}

class FilterEmployeeLoadMoreEvent extends FilterEmployeeSelectEvent {}

class FilterEmployeeSelectEmployeeEvent extends FilterEmployeeSelectEvent {
  final String employeeId;

  FilterEmployeeSelectEmployeeEvent({
    required this.employeeId,
  });
}

class FilterEmployeeClearSelectionEvent extends FilterEmployeeSelectEvent {}

class FilterEmployeeClearInputEvent extends FilterEmployeeSelectEvent {}
