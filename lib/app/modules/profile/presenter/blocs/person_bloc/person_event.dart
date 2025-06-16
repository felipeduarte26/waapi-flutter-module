import 'package:equatable/equatable.dart';

abstract class PersonEvent extends Equatable {
  const PersonEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class GetPersonIdEvent extends PersonEvent {
  final String employeeId;

  const GetPersonIdEvent({
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
