import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../enums/vacation_detail_type_enum.dart';
import '../../enums/vacation_situation_type_enum.dart';
import '../../enums/vacation_type_enum.dart';
import '../../infra/models/vacation_detail_attachments_model.dart';
import '../../infra/models/vacation_detail_model.dart';
import '../../infra/models/vacation_signature_data_model.dart';
import 'vacation_signature_data_model_mapper.dart';

class VacationDetailModelMapper {
  static VacationDetailModel fromMap({
    required Map<String, dynamic> map,
    required Map<String, dynamic> mapSignature,
    required VacationDetailTypeEnum detailType,
    final List<VacationDetailAttachmentsModel>? mapAttachments,
    final String? commentary,
    final String? approverCommentary,
    final String? integrationErrorMessage,
    final String? id,
  }) {
    VacationSituationTypeEnum? vacationDetailTypeEnum;
    switch (detailType) {
      case VacationDetailTypeEnum.receipt:
        vacationDetailTypeEnum = VacationSituationTypeEnum.paid;
        break;
      case VacationDetailTypeEnum.schedule:
        vacationDetailTypeEnum = VacationSituationTypeEnum.approved;
        break;
      case VacationDetailTypeEnum.waitingApproval:
        vacationDetailTypeEnum = VacationSituationTypeEnum.waitingApproval;
        break;
      case VacationDetailTypeEnum.returnedToAdjustments:
        vacationDetailTypeEnum = VacationSituationTypeEnum.returnedToAdjustments;
        break;
      case VacationDetailTypeEnum.underAnalysis:
        vacationDetailTypeEnum = VacationSituationTypeEnum.underAnalysis;
        break;
      case VacationDetailTypeEnum.expiredByLeader:
        vacationDetailTypeEnum = VacationSituationTypeEnum.expired;
        break;
    }

    if (detailType == VacationDetailTypeEnum.returnedToAdjustments) {
      return VacationDetailModel(
        vacationDays: map['vacationDays'] is num ? map['vacationDays']?.toDouble() : 0,
        vacationBonusDays: map['vacationBonusDays'] is num ? map['vacationBonusDays']?.toDouble() : 0,
        startDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
          stringToConvert: map['startDate'],
        ),
        has13thSalaryAdvance: map['has13thSalaryAdvance'] is bool ? map['has13thSalaryAdvance'] : false,
        vacationType: EnumHelper<VacationTypeEnum>().stringToEnum(
          stringToParse: map['type'],
          values: VacationTypeEnum.values,
        ),
        detailType: detailType,
        situationType: vacationDetailTypeEnum,
        approverCommentary: approverCommentary,
        id: id,
        commentary: commentary,
        attachments: mapAttachments,
        integrationErrorMessage: integrationErrorMessage,
      );
    }
    return VacationDetailModel(
      integrationErrorMessage: integrationErrorMessage,
      id: map['id'] ?? map['vacationId'],
      commentary: commentary,
      approverCommentary: approverCommentary,
      vacationDays: map['vacationDays'] is num ? map['vacationDays']?.toDouble() : 0,
      vacationBonusDays: map['vacationBonusDays'] is num ? map['vacationBonusDays']?.toDouble() : 0,
      startDate: vacationDetailTypeEnum == VacationSituationTypeEnum.expired
          ? DateTimeHelper.convertStringAaaaMmDdToDateTime(
              stringToConvert: map['date'],
            )
          : DateTimeHelper.convertStringAaaaMmDdToDateTime(
              stringToConvert: map['startDate'],
            ),
      has13thSalaryAdvance: map['has13thSalaryAdvance'] is bool ? map['has13thSalaryAdvance'] : false,
      vacationType: EnumHelper<VacationTypeEnum>().stringToEnum(
        stringToParse: map['type'],
        values: VacationTypeEnum.values,
      ),
      detailType: detailType,
      situationType: vacationDetailTypeEnum,
      attachments: mapAttachments,
      reportLink: map['reportLink'] == '' ? null : map['reportLink'],
      reportVacationNoticeLink: map['reportVacationNoticeLink'] == '' ? null : map['reportVacationNoticeLink'],
      vacationNoticeSignatureData: searchVacationSignatureNotice(
        mapSignature,
        map,
        'VACATION_NOTICE',
      ),
      vacationReceiptSignatureData: searchVacationSignatureNotice(
        mapSignature,
        map,
        'VACATION_RECEIPT',
      ),
    );
  }

  static VacationSignatureDataModel? searchVacationSignatureNotice(
    Map<String, dynamic> vacationSignatureData,
    Map<String, dynamic> vacationData,
    String documentType,
  ) {
    VacationSignatureDataModel? signatureDataModel;

    if (vacationSignatureData.containsKey('vacationReceiptSignatures')) {
      final vacationReceiptSignatures = (vacationSignatureData['vacationReceiptSignatures'] as List).where(
        (element) =>
            element['vacationReceiptId'] ==
            (vacationData['id'] ?? vacationData['vacationId'] ?? vacationData['vacationReceiptId']),
      );

      for (var vacationReceiptSignature in vacationReceiptSignatures) {
        final signature = (vacationReceiptSignature['signatures'] as List).where(
          (element) {
            return (element['status'] == 'IN_SIGNATURE' || element['status'] == 'SIGNED') &&
                element['documentType'] == documentType;
          },
        ).firstOrNull;

        if (signature != null) {
          signatureDataModel = VacationSignatureDataModelMapper().fromMap(
            map: signature,
          );
          break;
        }
      }
    }

    if (vacationSignatureData.containsKey('individualVacationScheduleSignatures')) {
      final individualVacationScheduleSignatures =
          (vacationSignatureData['individualVacationScheduleSignatures'] as List).where(
        (element) =>
            element['individualVacationScheduleId'] ==
            (vacationData['id'] ?? vacationData['vacationId'] ?? vacationData['vacationReceiptId']),
      );

      for (var vacationReceiptSignature in individualVacationScheduleSignatures) {
        final signature = vacationReceiptSignature['signature'];
        final hasSignature = (signature['status'] == 'IN_SIGNATURE' || signature['status'] == 'SIGNED') &&
            signature['documentType'] == documentType;

        if (hasSignature) {
          signatureDataModel = VacationSignatureDataModelMapper().fromMap(
            map: signature,
          );
          break;
        }
      }
    }

    return signatureDataModel;
  }
}
