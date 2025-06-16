import 'package:equatable/equatable.dart';

import '../../../domain/entities/employees_by_year_hire_entity.dart';

abstract class CompanyBirthdaysState extends Equatable {
  final List<EmployeesByYearHireEntity> employeesByYearHireEntityList;

  const CompanyBirthdaysState({
    this.employeesByYearHireEntityList = const [],
  });

  LoadingCompanyBirthdaysState loadingCompanyBirthdaysState() {
    return const LoadingCompanyBirthdaysState();
  }

  LoadingMoreCompanyBirthdaysState loadingMoreCompanyBirthdaysState({
    required List<EmployeesByYearHireEntity> employeesByYearHireEntityList,
  }) {
    return LoadingMoreCompanyBirthdaysState(
      employeesByYearHireEntityList: employeesByYearHireEntityList,
    );
  }

  LoadedCompanyBirthdaysState loadedCompanyBirthdaysState({
    required List<EmployeesByYearHireEntity> employeesByYearHireEntityList,
  }) {
    return LoadedCompanyBirthdaysState(
      employeesByYearHireEntityList: employeesByYearHireEntityList,
    );
  }

  LastPageCompanyBirthdaysState lastPageCompanyBirthdaysState({
    required List<EmployeesByYearHireEntity> employeesByYearHireEntityList,
  }) {
    return LastPageCompanyBirthdaysState(
      employeesByYearHireEntityList: employeesByYearHireEntityList,
    );
  }

  EmptyCompanyBirthdaysState emptyCompanyBirthdaysState() {
    return const EmptyCompanyBirthdaysState();
  }

  ErrorCompanyBirthdaysState errorCompanyBirthdaysState() {
    return const ErrorCompanyBirthdaysState();
  }

  ErrorLoadingMoreCompanyBirthdaysState errorLoadingMoreErrorCompanyBirthdaysState({
    required List<EmployeesByYearHireEntity> employeesByYearHireEntityList,
  }) {
    return ErrorLoadingMoreCompanyBirthdaysState(
      employeesByYearHireEntityList: employeesByYearHireEntityList,
    );
  }

  @override
  List<Object?> get props {
    return [
      employeesByYearHireEntityList,
    ];
  }
}

class InitialCompanyBirthdaysState extends CompanyBirthdaysState {
  const InitialCompanyBirthdaysState() : super();
}

class LoadingCompanyBirthdaysState extends CompanyBirthdaysState {
  const LoadingCompanyBirthdaysState() : super();
}

class LoadingMoreCompanyBirthdaysState extends CompanyBirthdaysState {
  const LoadingMoreCompanyBirthdaysState({
    required List<EmployeesByYearHireEntity> employeesByYearHireEntityList,
  }) : super(employeesByYearHireEntityList: employeesByYearHireEntityList);
}

class LoadedCompanyBirthdaysState extends CompanyBirthdaysState {
  const LoadedCompanyBirthdaysState({
    required List<EmployeesByYearHireEntity> employeesByYearHireEntityList,
  }) : super(employeesByYearHireEntityList: employeesByYearHireEntityList);
}

class LastPageCompanyBirthdaysState extends CompanyBirthdaysState {
  const LastPageCompanyBirthdaysState({
    required List<EmployeesByYearHireEntity> employeesByYearHireEntityList,
  }) : super(employeesByYearHireEntityList: employeesByYearHireEntityList);
}

class EmptyCompanyBirthdaysState extends CompanyBirthdaysState {
  const EmptyCompanyBirthdaysState() : super();
}

class ErrorCompanyBirthdaysState extends CompanyBirthdaysState {
  const ErrorCompanyBirthdaysState() : super();
}

class ErrorLoadingMoreCompanyBirthdaysState extends CompanyBirthdaysState {
  const ErrorLoadingMoreCompanyBirthdaysState({
    required List<EmployeesByYearHireEntity> employeesByYearHireEntityList,
  }) : super(employeesByYearHireEntityList: employeesByYearHireEntityList);
}

class ReloadCompanyBirthdaysState extends CompanyBirthdaysState {}
