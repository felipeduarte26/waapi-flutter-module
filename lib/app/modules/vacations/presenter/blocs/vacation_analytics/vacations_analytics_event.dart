import 'package:equatable/equatable.dart';

abstract class VacationsAnalyticsEvent extends Equatable {}

class GetVacationsAnalyticsEvent extends VacationsAnalyticsEvent {
  final String employeeId;

  GetVacationsAnalyticsEvent({
    required this.employeeId,
  });

  @override
  List<Object> get props {
    return [
      employeeId,
    ];
  }
}
