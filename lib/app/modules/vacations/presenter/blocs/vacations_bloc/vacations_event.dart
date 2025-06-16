import 'package:equatable/equatable.dart';

abstract class VacationsEvent extends Equatable {
  const VacationsEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class GetVacationsEvent extends VacationsEvent {
  final String employeeId;

  const GetVacationsEvent({
    required this.employeeId,
  });

  @override
  List<Object> get props {
    return [
      ...super.props,
      employeeId,
    ];
  }
}
