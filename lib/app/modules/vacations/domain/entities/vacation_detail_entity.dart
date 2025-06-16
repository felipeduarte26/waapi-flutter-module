import 'package:equatable/equatable.dart';

import '../../enums/vacation_detail_type_enum.dart';
import '../../enums/vacation_situation_type_enum.dart';
import '../../enums/vacation_type_enum.dart';
import 'vacation_detail_attachments_entity.dart';
import 'vacation_signature_data_entity.dart';

class VacationDetailEntity extends Equatable {
  final String? id;
  final double? vacationDays;
  final double? vacationBonusDays;
  final DateTime? startDate;
  final bool? has13thSalaryAdvance;
  final VacationTypeEnum? vacationType;
  final VacationDetailTypeEnum? detailType;
  final VacationSituationTypeEnum? situationType;
  final List<VacationDetailAttachmentsEntity>? attachments;
  final String? commentary;
  final String? approverCommentary;
  final String? integrationErrorMessage;
  final String? reportLink;
  final String? reportVacationNoticeLink;
  final VacationSignatureDataEntity? vacationReceiptSignatureData;
  final VacationSignatureDataEntity? vacationNoticeSignatureData;

  const VacationDetailEntity({
    this.id,
    this.vacationDays,
    this.vacationBonusDays,
    this.startDate,
    this.has13thSalaryAdvance,
    this.vacationType,
    this.detailType,
    this.situationType,
    this.attachments,
    this.commentary,
    this.approverCommentary,
    this.integrationErrorMessage,
    this.reportLink,
    this.reportVacationNoticeLink,
    this.vacationNoticeSignatureData,
    this.vacationReceiptSignatureData,
  });

  @override
  List<Object?> get props {
    return [
      id,
      vacationDays,
      vacationBonusDays,
      startDate,
      has13thSalaryAdvance,
      vacationType,
      detailType,
      situationType,
      attachments,
      commentary,
      approverCommentary,
      integrationErrorMessage,
      reportLink,
      reportVacationNoticeLink,
      vacationNoticeSignatureData,
      vacationReceiptSignatureData,
    ];
  }
}
