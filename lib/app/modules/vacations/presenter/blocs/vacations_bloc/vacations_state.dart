import 'package:equatable/equatable.dart';

import '../../../domain/entities/vacations_entity.dart';

abstract class VacationsState extends Equatable {
  final List<VacationsEntity>? vacations;

  const VacationsState({
    this.vacations,
  });

  LoadingVacationsState loadingVacationsState() {
    return LoadingVacationsState(
      vacations: vacations,
    );
  }

  ErrorUpdatingVacationsState errorUpdatingVacationsState() {
    return ErrorUpdatingVacationsState(
      vacations: vacations,
    );
  }

  LoadedVacationsState loadedVacationsState({
    required List<VacationsEntity> vacations,
    required String employeeId,
  }) {
    return LoadedVacationsState(
      vacations: vacations,
      employeeId: employeeId,
    );
  }

  @override
  List<Object?> get props {
    return [];
  }
}

class InitialVacationsState extends VacationsState {
  const InitialVacationsState() : super();
}

class LoadingVacationsState extends VacationsState {
  const LoadingVacationsState({
    List<VacationsEntity>? vacations,
  }) : super(vacations: vacations);
}

class LoadedVacationsState extends VacationsState {
  final String employeeId;
  const LoadedVacationsState({
    required List<VacationsEntity> vacations,
    required this.employeeId,
  }) : super(vacations: vacations);
}

class ErrorUpdatingVacationsState extends VacationsState {
  const ErrorUpdatingVacationsState({
    List<VacationsEntity>? vacations,
  }) : super(vacations: vacations);
}

class ErrorVacationsState extends VacationsState {
  final String employeeId;
  const ErrorVacationsState({
    required this.employeeId,
  }) : super();
}
