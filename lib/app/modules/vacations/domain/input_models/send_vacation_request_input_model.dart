import 'package:equatable/equatable.dart';

import 'send_vacation_request_attachments_input_model.dart';

class SendVacationRequestInputModel extends Equatable {
  final String startDate;
  final String? vacationsDays;
  final bool has13thSalaryAdvance;
  final String? vacationBonusDays;
  final String? commentary;
  final String? approverCommentary;
  final List<SendVacationRequestAttachmentsInputModel>? attachments;
  final String vacationPeriodId;
  final String employeeId;
  final String? integrationErrorMessage;

  const SendVacationRequestInputModel({
    required this.startDate,
    this.vacationsDays,
    required this.has13thSalaryAdvance,
    this.vacationBonusDays,
    this.commentary,
    this.approverCommentary,
    this.attachments,
    required this.vacationPeriodId,
    required this.employeeId,
    this.integrationErrorMessage,
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
      approverCommentary,
      integrationErrorMessage,
    ];
  }
}
