import 'package:equatable/equatable.dart';

import 'send_vacation_request_attachments_update_input_model.dart';

class SendVacationRequestUpdateInputModel extends Equatable {
  final String id;
  final String startDate;
  final String vacationsDays;
  final bool has13thSalaryAdvance;
  final String? vacationBonusDays;
  final String? commentary;
  final List<SendVacationRequestAttachmentsUpdateInputModel>? attachments;
  final String vacationPeriodId;
  final String employeeId;

  const SendVacationRequestUpdateInputModel({
    required this.startDate,
    required this.vacationsDays,
    required this.has13thSalaryAdvance,
    this.vacationBonusDays,
    this.commentary,
    this.attachments,
    required this.vacationPeriodId,
    required this.employeeId,
    required this.id,
  });

  @override
  List<Object?> get props {
    return [
      startDate,
      vacationsDays,
      has13thSalaryAdvance,
      vacationBonusDays,
      commentary,
      attachments,
      vacationPeriodId,
      employeeId,
      id,
    ];
  }
}
