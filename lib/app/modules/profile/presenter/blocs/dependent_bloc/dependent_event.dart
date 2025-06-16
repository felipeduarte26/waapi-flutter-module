import 'package:equatable/equatable.dart';

abstract class DependentEvent extends Equatable {
  const DependentEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class GetDependentsEvent extends DependentEvent {
  final String employeeId;

  const GetDependentsEvent({
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
