import '../../../../core/helper/enum_helper.dart';
import '../../domain/input_models/edit_personal_documents_civil_certificates_input_model.dart';
import '../../enums/civil_certificate_type_enum.dart';

class EditPersonalDocumentsCivilCertificatesInputModelMapper {
  Map<String, dynamic> toMap({
    required EditPersonalDocumentsCivilCertificatesInputModel inputModel,
  }) {
    return {
      if (inputModel.requestType == 'INSERT') 'create': true,
      if (inputModel.requestType != 'INSERT') 'civilCertificateId': inputModel.id,
      if (inputModel.enrollment != null) 'enrollment': inputModel.enrollment,
      if (inputModel.bookNumber != null) 'bookNumber': inputModel.bookNumber,
      if (inputModel.paperNumber != null) 'paperNumber': inputModel.paperNumber,
      if (inputModel.termNumber != null) 'termNumber': inputModel.termNumber,
      if (inputModel.registryName != null) 'registryName': inputModel.registryName,
      if (inputModel.issuedDate != null) 'issuedDate': inputModel.issuedDate,
      'requestType': inputModel.requestType,
      if (inputModel.cityId != null) 'cityId': inputModel.cityId,
      if (inputModel.updateDate != null) 'updateDate': inputModel.updateDate,
      'certificateType': EnumHelper<CivilCertificateTypeEnum>().enumToString(
        enumToParse: inputModel.certificateType,
      ),
      'canceled': false,
      'isValid': (inputModel.requestType == 'INSERT') ? [] : {},
      'isInvalid': false,
      'isLast': inputModel.isLast,
    };
  }
}
