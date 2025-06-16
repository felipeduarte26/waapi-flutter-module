import 'package:equatable/equatable.dart';

import '../../../domain/entities/employee_entity.dart';

abstract class SearchEmployeeState extends Equatable {
  final List<EmployeeEntity> employeeList;
  final EmployeeEntity? selectedEmployeeEntity;

  const SearchEmployeeState({
    this.employeeList = const [],
    this.selectedEmployeeEntity,
  });

  SearchEmployeeState initialSearchEmployeeState() {
    return InitialSearchEmployeeState(
      employeeEntity: selectedEmployeeEntity,
    );
  }

  SearchEmployeeState loadingSearchEmployeeState() {
    return LoadingSearchEmployeeState(
      employeeEntity: selectedEmployeeEntity,
    );
  }

  SearchEmployeeState emptyStateSearchEmployeesState() {
    return EmptyStateSearchEmployeesState(
      employeeEntity: selectedEmployeeEntity,
    );
  }

  SearchEmployeeState loadedSearchEmployeeState({
    required List<EmployeeEntity> employeeList,
  }) {
    return LoadedSearchEmployeeState(
      employeeList: employeeList,
      employeeEntity: selectedEmployeeEntity,
    );
  }

  SearchEmployeeState loadedSelectEmployeeState({
    required EmployeeEntity employeeEntity,
  }) {
    return LoadedSelectEmployeeState(
      employeeEntity: employeeEntity,
    );
  }

  SearchEmployeeState errorSearchEmployeeState({
    String? message,
    required String search,
  }) {
    return ErrorSearchEmployeeState(
      message: message,
      search: search,
      employeeEntity: selectedEmployeeEntity,
    );
  }

  @override
  List<Object?> get props {
    return [
      employeeList,
      selectedEmployeeEntity,
    ];
  }
}

class InitialSearchEmployeeState extends SearchEmployeeState {
  const InitialSearchEmployeeState({
    EmployeeEntity? employeeEntity,
  }) : super(
          employeeList: const [],
          selectedEmployeeEntity: employeeEntity,
        );
}

class LoadingSearchEmployeeState extends SearchEmployeeState {
  const LoadingSearchEmployeeState({
    EmployeeEntity? employeeEntity,
  }) : super(
          employeeList: const [],
          selectedEmployeeEntity: employeeEntity,
        );
}

class EmptyStateSearchEmployeesState extends SearchEmployeeState {
  const EmptyStateSearchEmployeesState({
    EmployeeEntity? employeeEntity,
  }) : super(
          employeeList: const [],
          selectedEmployeeEntity: employeeEntity,
        );
}

class LoadedSearchEmployeeState extends SearchEmployeeState {
  const LoadedSearchEmployeeState({
    required List<EmployeeEntity> employeeList,
    EmployeeEntity? employeeEntity,
  }) : super(
          employeeList: employeeList,
          selectedEmployeeEntity: employeeEntity,
        );
}

class LoadingSelectEmployeeState extends SearchEmployeeState {
  const LoadingSelectEmployeeState({
    EmployeeEntity? employeeEntity,
  }) : super(selectedEmployeeEntity: employeeEntity);
}

class LoadedSelectEmployeeState extends SearchEmployeeState {
  const LoadedSelectEmployeeState({
    required EmployeeEntity employeeEntity,
  }) : super(selectedEmployeeEntity: employeeEntity);
}

class ErrorSearchEmployeeState extends SearchEmployeeState {
  final String? message;
  final String search;

  const ErrorSearchEmployeeState({
    required this.message,
    required this.search,
    EmployeeEntity? employeeEntity,
  }) : super(selectedEmployeeEntity: employeeEntity);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
      search,
    ];
  }
}
