import 'package:equatable/equatable.dart';

import '../../../domain/entities/employees_by_birthday_entity.dart';

abstract class BirthdayEmployeesState extends Equatable {
  final List<EmployeesByBirthdayEntity> birthdayEmployees;

  const BirthdayEmployeesState({
    this.birthdayEmployees = const [],
  });

  LoadingBirthdayEmployeesState loadingBirthdayEmployeesState() {
    return const LoadingBirthdayEmployeesState();
  }

  LoadingMoreBirthdayEmployeesState loadingMoreBirthdayEmployeesState({
    required List<EmployeesByBirthdayEntity> birthdayEmployees,
  }) {
    return LoadingMoreBirthdayEmployeesState(
      birthdayEmployees: birthdayEmployees,
    );
  }

  LoadedBirthdayEmployeesState loadedBirthdayEmployeesState({
    required List<EmployeesByBirthdayEntity> birthdayEmployees,
  }) {
    return LoadedBirthdayEmployeesState(
      birthdayEmployees: birthdayEmployees,
    );
  }

  LastPageBirthdayEmployeesState lastPageBirthdayEmployeesState({
    required List<EmployeesByBirthdayEntity> birthdayEmployees,
  }) {
    return LastPageBirthdayEmployeesState(
      birthdayEmployees: birthdayEmployees,
    );
  }

  EmptyBirthdayEmployeesState emptyBirthdayEmployeesState() {
    return const EmptyBirthdayEmployeesState();
  }

  ErrorBirthdayEmployeesState errorBirthdayEmployeesState() {
    return const ErrorBirthdayEmployeesState();
  }

  ErrorLoadingMoreBirthdayEmployeesState errorLoadingMoreBirthdayEmployeesState({
    required List<EmployeesByBirthdayEntity> birthdayEmployees,
  }) {
    return ErrorLoadingMoreBirthdayEmployeesState(
      birthdayEmployees: birthdayEmployees,
    );
  }

  @override
  List<Object?> get props {
    return [
      birthdayEmployees,
    ];
  }
}

class InitialBirthdayEmployeesState extends BirthdayEmployeesState {
  const InitialBirthdayEmployeesState() : super();
}

class LoadingBirthdayEmployeesState extends BirthdayEmployeesState {
  const LoadingBirthdayEmployeesState() : super();
}

class LoadingMoreBirthdayEmployeesState extends BirthdayEmployeesState {
  const LoadingMoreBirthdayEmployeesState({
    required List<EmployeesByBirthdayEntity> birthdayEmployees,
  }) : super(birthdayEmployees: birthdayEmployees);
}

class LoadedBirthdayEmployeesState extends BirthdayEmployeesState {
  const LoadedBirthdayEmployeesState({
    required List<EmployeesByBirthdayEntity> birthdayEmployees,
  }) : super(birthdayEmployees: birthdayEmployees);
}

class LastPageBirthdayEmployeesState extends BirthdayEmployeesState {
  const LastPageBirthdayEmployeesState({
    required List<EmployeesByBirthdayEntity> birthdayEmployees,
  }) : super(birthdayEmployees: birthdayEmployees);
}

class EmptyBirthdayEmployeesState extends BirthdayEmployeesState {
  const EmptyBirthdayEmployeesState() : super();
}

class ErrorBirthdayEmployeesState extends BirthdayEmployeesState {
  const ErrorBirthdayEmployeesState() : super();
}

class ErrorLoadingMoreBirthdayEmployeesState extends BirthdayEmployeesState {
  const ErrorLoadingMoreBirthdayEmployeesState({
    required List<EmployeesByBirthdayEntity> birthdayEmployees,
  }) : super(birthdayEmployees: birthdayEmployees);
}

class ReloadBirthdayEmployeesState extends BirthdayEmployeesState {}
