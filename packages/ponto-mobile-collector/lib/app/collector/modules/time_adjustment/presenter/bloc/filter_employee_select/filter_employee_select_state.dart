abstract class FilterEmployeeSelectState {}

class FilterEmployeeSearchInProgress
    implements FilterEmployeeSelectState {}

class FilterEmployeeSearchLoadMoreInProgress
    implements FilterEmployeeSelectState {}

class FilterEmployeeSearchInitial
    implements FilterEmployeeSelectState {}

class FilterReadyContent implements FilterEmployeeSelectState {}

class FilterEmployeeSelected implements FilterEmployeeSelectState {}

class FilterEmployeeSearchFailure
    implements FilterEmployeeSelectState {}

class FilterEmployeeSearchOffline
    implements FilterEmployeeSelectState {}
