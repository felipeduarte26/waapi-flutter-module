abstract class EmployeeSearchState {}

class EmployeeSearchInProgress implements EmployeeSearchState {}

class EmployeeSearchLoadMoreInProgress implements EmployeeSearchState {}

class EmployeeSearchInitial implements EmployeeSearchState {}

class EmployeeSearchSuccess implements EmployeeSearchState {}

class EmployeeSearchFailure implements EmployeeSearchState {}

class EmployeeSearchNotPermission implements EmployeeSearchState {}

class EmployeeSearchOffline implements EmployeeSearchState {}
