import 'package:equatable/equatable.dart';
import '../enums/clocking_event_use_type.dart';

class ClockingEventUse extends Equatable {
  final String description;
  final String code;
  final ClockingEventUseType clockingEventUseType;
  final String? employeeId;

  const ClockingEventUse({
    required this.description,
    required this.code,
    required this.clockingEventUseType,
    this.employeeId,
  });

  ClockingEventUse copyWith({
    String? description,
    String? code,
    ClockingEventUseType? clockingEventUseType,
    String? employeeId,
  }) {
    return ClockingEventUse(
      description: description ?? this.description,
      code: code ?? this.code,
      clockingEventUseType: clockingEventUseType ?? this.clockingEventUseType,
      employeeId: employeeId ?? this.employeeId,
    );
  }

  @override
  List<Object?> get props => [
        description,
        code,
        clockingEventUseType,
        employeeId,
      ];
}
