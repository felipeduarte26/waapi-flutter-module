import 'package:equatable/equatable.dart';

class SendCancelationApprovedRequestInputModel extends Equatable {
  final String vacationScheduleToCancelId;
  final String employeeId;

  const SendCancelationApprovedRequestInputModel({
    required this.vacationScheduleToCancelId,
    required this.employeeId,
  });
  @override
  List<Object> get props => [
        vacationScheduleToCancelId,
        employeeId,
      ];
}
