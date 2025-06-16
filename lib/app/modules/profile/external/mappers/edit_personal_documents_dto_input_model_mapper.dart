import '../../domain/input_models/edit_personal_documents_dto_input_model.dart';
import 'edit_personal_documents_civil_certificates_input_model_mapper.dart';

class EditPersonalDocumentsDtoInputModelMapper {
  Map<String, dynamic> toMap({
    required EditPersonalDocumentsDtoInputModel inputModel,
  }) {
    return {
      if (inputModel.commentary != null) 'commentary': inputModel.commentary,
      if (inputModel.rgNumber != null) 'rgNumber': inputModel.rgNumber,
      if (inputModel.rgIssuer != null) 'rgIssuer': inputModel.rgIssuer,
      if (inputModel.rgIssuingState != null) 'rgIssuingState': inputModel.rgIssuingState,
      if (inputModel.rgIssuedDate != null) 'rgIssuedDate': inputModel.rgIssuedDate,
      if (inputModel.cnhNumber != null) 'cnhNumber': inputModel.cnhNumber,
      if (inputModel.cnhCategory != null) 'cnhCategory': inputModel.cnhCategory,
      if (inputModel.cnhIssuer != null) 'cnhIssuer': inputModel.cnhIssuer,
      if (inputModel.cnhIssuerState != null) 'cnhIssuerState': inputModel.cnhIssuerState,
      if (inputModel.cnhFirstIssuedDate != null) 'cnhFirstIssuedDate': inputModel.cnhFirstIssuedDate,
      if (inputModel.cnhIssuedDate != null) 'cnhIssuedDate': inputModel.cnhIssuedDate,
      if (inputModel.cnhExpiryDate != null) 'cnhExpiryDate': inputModel.cnhExpiryDate,
      if (inputModel.passportNumber != null) 'passportNumber': inputModel.passportNumber,
      if (inputModel.passportIssuer != null) 'passportIssuer': inputModel.passportIssuer,
      if (inputModel.passportIssuedDate != null) 'passportIssuedDate': inputModel.passportIssuedDate,
      if (inputModel.passportExpiryDate != null) 'passportExpiryDate': inputModel.passportExpiryDate,
      if (inputModel.passportIssuingCountryId != null) 'passportIssuingCountryId': inputModel.passportIssuingCountryId,
      if (inputModel.passportIssuingState != null) 'passportIssuingState': inputModel.passportIssuingState,
      if (inputModel.voterRegistrationNumber != null) 'voterRegistrationNumber': inputModel.voterRegistrationNumber,
      if (inputModel.voterRegistrationZone != null) 'voterRegistrationZone': inputModel.voterRegistrationZone,
      if (inputModel.voterRegistrationSection != null) 'voterRegistrationSection': inputModel.voterRegistrationSection,
      if (inputModel.reservistCertificateNumber != null)
        'reservistCertificateNumber': inputModel.reservistCertificateNumber,
      if (inputModel.reservistCertificateCategory != null)
        'reservistCertificateCategory': inputModel.reservistCertificateCategory,
      if (inputModel.ricNumber != null) 'ricNumber': inputModel.ricNumber,
      if (inputModel.ricIssuer != null) 'ricIssuer': inputModel.ricIssuer,
      if (inputModel.ricIssuedDate != null) 'ricIssuedDate': inputModel.ricIssuedDate,
      if (inputModel.nationalHealthCard != null) 'nationalHealthCard': inputModel.nationalHealthCard,
      'cpf': inputModel.cpf,
      'isForeigner': inputModel.isForeigner,
      'gender': inputModel.gender,
      'isRealData': inputModel.isRealData,
      'nisNumber': inputModel.nisNumber,
      'nisRegistrationDate': inputModel.nisRegistrationDate,
      'ctpsNumber': inputModel.ctpsNumber,
      'ctpsSerie': inputModel.ctpsSerie,
      'ctpsSerieDigit': inputModel.ctpsSerieDigit,
      'ctpsIssuedDate': inputModel.ctpsIssuedDate,
      'ctpsState': inputModel.ctpsState,
      'foreignerBrazilianChildren': inputModel.foreignerBrazilianChildren,
      'foreignerMarriedWithBrazilian': inputModel.foreignerMarriedWithBrazilian,
      'civilCertificates': inputModel.civilCertificates.map((editPersonalDocumentsCivilCertificatesInputModel) {
        return EditPersonalDocumentsCivilCertificatesInputModelMapper().toMap(
          inputModel: editPersonalDocumentsCivilCertificatesInputModel,
        );
      }).toList(),
    };
  }
}
