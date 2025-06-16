import '../../../../core/helper/enum_helper.dart';
import '../../enums/vacation_document_status_enum.dart';
import '../../enums/vacation_document_type_enum.dart';
import '../../infra/models/vacation_signature_data_model.dart';

class VacationSignatureDataModelMapper {
  VacationSignatureDataModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return VacationSignatureDataModel(
      documentType: EnumHelper<VacationDocumentTypeEnum>().stringToEnum(
            stringToParse: map['documentType'],
            values: VacationDocumentTypeEnum.values,
          ) ??
          VacationDocumentTypeEnum.vacationReceipt,
      gedSignatureLink: map['gedSignatureLink'] ?? '',
      signedDocumentUrl: map['signedDocumentUrl'],
      status: EnumHelper<VacationDocumentStatusEnum>().stringToEnum(
            stringToParse: map['status'],
            values: VacationDocumentStatusEnum.values,
          ) ??
          VacationDocumentStatusEnum.inSignature,
    );
  }
}
