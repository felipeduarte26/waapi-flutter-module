abstract class TimeAdjustmentSelectEmployeeState {}

class MultipleEmployeeSearchInProgress
    implements TimeAdjustmentSelectEmployeeState {}

class MultipleEmployeeSearchLoadMoreInProgress
    implements TimeAdjustmentSelectEmployeeState {}

class MultipleEmployeeSearchInitial
    implements TimeAdjustmentSelectEmployeeState {}

class MultipleReadyContent implements TimeAdjustmentSelectEmployeeState {}

class MultipleEmployeeSelected implements TimeAdjustmentSelectEmployeeState {
}

class MultipleEmployeeSearchFailure
    implements TimeAdjustmentSelectEmployeeState {}

class MultipleEmployeeSearchOffline
    implements TimeAdjustmentSelectEmployeeState {}
