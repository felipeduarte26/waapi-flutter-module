import '../../domain/entities/vacation_signature_data_entity.dart';
import '../models/vacation_signature_data_model.dart';

class VacationSignatureDataEntityAdapter {
  static VacationSignatureDataEntity fromModel({
    required VacationSignatureDataModel vacationSignatureDataModel,
  }) {
    return VacationSignatureDataEntity(
      documentType: vacationSignatureDataModel.documentType,
      gedSignatureLink: vacationSignatureDataModel.gedSignatureLink,
      signedDocumentUrl: vacationSignatureDataModel.signedDocumentUrl,
      status: vacationSignatureDataModel.status,
    );
  }
}
