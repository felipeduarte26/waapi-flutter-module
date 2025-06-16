import 'package:equatable/equatable.dart';

import '../../../domain/entities/vacations_analytics_entity.dart';

abstract class VacationsAnalyticsState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class LoadedVacationsAnalyticsState extends VacationsAnalyticsState {
  final VacationsAnalyticsEntity vacationsAnalyticsEntity;

  LoadedVacationsAnalyticsState({
    required this.vacationsAnalyticsEntity,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      vacationsAnalyticsEntity,
    ];
  }
}

class ErrorVacationsAnalyticsState extends VacationsAnalyticsState {
  final String employeeId;

  ErrorVacationsAnalyticsState({
    required this.employeeId,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      employeeId,
    ];
  }
}

class LoadingVacationsAnalyticsState extends VacationsAnalyticsState {}

class InitialVacationsAnalyticsState extends VacationsAnalyticsState {}
