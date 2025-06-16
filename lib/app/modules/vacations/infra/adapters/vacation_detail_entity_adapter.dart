import '../../domain/entities/vacation_detail_attachments_entity.dart';
import '../../domain/entities/vacation_detail_entity.dart';
import '../models/vacation_detail_model.dart';
import 'vacation_signature_data_entity_adapter.dart';

class VacationDetailEntityAdapter {
  static VacationDetailEntity fromModel({
    required VacationDetailModel vacationDetailModel,
  }) {
    return VacationDetailEntity(
      vacationReceiptSignatureData: vacationDetailModel.vacationReceiptSignatureData != null
          ? VacationSignatureDataEntityAdapter.fromModel(
              vacationSignatureDataModel: vacationDetailModel.vacationReceiptSignatureData!,
            )
          : null,
      vacationNoticeSignatureData: vacationDetailModel.vacationNoticeSignatureData != null
          ? VacationSignatureDataEntityAdapter.fromModel(
              vacationSignatureDataModel: vacationDetailModel.vacationNoticeSignatureData!,
            )
          : null,
      id: vacationDetailModel.id,
      has13thSalaryAdvance: vacationDetailModel.has13thSalaryAdvance,
      startDate: vacationDetailModel.startDate,
      vacationBonusDays: vacationDetailModel.vacationBonusDays,
      vacationDays: vacationDetailModel.vacationDays,
      vacationType: vacationDetailModel.vacationType,
      detailType: vacationDetailModel.detailType,
      situationType: vacationDetailModel.situationType,
      commentary: vacationDetailModel.commentary,
      approverCommentary: vacationDetailModel.approverCommentary,
      integrationErrorMessage: vacationDetailModel.integrationErrorMessage,
      reportLink: vacationDetailModel.reportLink,
      reportVacationNoticeLink: vacationDetailModel.reportVacationNoticeLink,
      attachments: vacationDetailModel.attachments
          ?.map(
            (attachments) => VacationDetailAttachmentsEntity(
              id: attachments.id,
              name: attachments.name,
              link: attachments.link,
              personId: attachments.personId,
              sourceId: attachments.sourceId,
              sourceType: attachments.sourceType,
            ),
          )
          .toList(),
    );
  }
}
