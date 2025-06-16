import 'dart:convert';

import '../../infra/models/legacy_authorization_model.dart';

class LegacyAuthorizationModelMapper {
  late final List requestUpdatePermissions;

  LegacyAuthorizationModel fromMap({
    required Map<String, dynamic> map,
  }) {
    requestUpdatePermissions = map['requestUpdatePermission'] ?? [];
    bool personalDataName = false;
    bool personalDataBirthday = false;
    bool personalDataBirthplace = false;
    bool personalDataDisability = false;
    bool personalDataEducationLevel = false;
    bool personalDataGender = false;
    bool personalDataMaritalStatus = false;
    bool personalDataNationality = false;
    bool personalDataNotes = false;
    bool personalDataRace = false;
    bool contactProfessionalEmail = false;
    bool contactPhoneType = false;
    bool contactPersonalEmail = false;
    bool contactPhoneDDI = false;
    bool contactPhoneDDD = false;
    bool contactPhoneNumber = false;
    bool contactPhoneExtension = false;
    bool contactPhoneProvider = false;
    bool contactPhoneAction = false;
    bool contactEmailType = false;
    bool contactEmailDescription = false;
    bool contactEmailAction = false;
    bool contactSocialNetworkType = false;
    bool contactSocialNetworkUsername = false;
    bool contactSocialNetworkAction = false;
    bool contactNotes = false;
    bool documentCpf = false;
    bool documentRgNumber = false;
    bool documentRgIssuanceDate = false;
    bool documentRgIssuingBody = false;
    bool documentRgIssuingState = false;
    bool documentVoterNumber = false;
    bool documentVoterZone = false;
    bool documentVoterSection = false;
    bool documentCtpsIssuedDate = false;
    bool documentCtpsState = false;
    bool documentCtpsDigit = false;
    bool documentCtpsSerie = false;
    bool documentCtpsNumber = false;
    bool documentCnhNumber = false;
    bool documentCnhCategory = false;
    bool documentCnhIssuingBody = false;
    bool documentCnhIssuingState = false;
    bool documentCnhIssuanceDate = false;
    bool documentCnhFirstIssuedDate = false;
    bool documentCnhExpiryDate = false;
    bool documentRicNumber = false;
    bool documentRicIssuanceDate = false;
    bool documentRicIssuingBody = false;
    bool documentRicIssuingCity = false;
    bool documentPassportNumber = false;
    bool documentPassportCountry = false;
    bool documentPassportIssuingBody = false;
    bool documentPassportState = false;
    bool documentPassportIssuanceDate = false;
    bool documentPassportExpiryDate = false;
    bool documentNisNumber = false;
    bool documentNisRegistrationDate = false;
    bool documentReservistNumber = false;
    bool documentReservistCategory = false;
    bool documentCnsNumber = false;
    bool documentCertificate = false;
    bool documentAttachment = false;
    bool documentNotes = false;
    bool documentVisaNumber = false;
    bool documentVisaIssuedDate = false;
    bool documentVisaExpiryDate = false;
    bool documentVisaType = false;
    bool documentRneNumber = false;
    bool documentRneIssuingBody = false;
    bool documentRneIssuedDate = false;
    bool addressZipCode = false;
    bool addressPatioType = false;
    bool addressPatio = false;
    bool addressNumber = false;
    bool addressAdditional = false;
    bool addressNeighborhood = false;
    bool addressCity = false;
    bool addressAdmRegion = false;
    bool addressNotes = false;
    bool emergencyContactPhoneDDD = false;
    bool emergencyContactPhoneDDI = false;
    bool emergencyContactPhoneExtension = false;
    bool emergencyContactPhoneGender = false;
    bool emergencyContactPhoneKinship = false;
    bool emergencyContactPhoneName = false;
    bool emergencyContactPhoneNumber = false;
    bool emergencyContactPhoneProvider = false;

    if (requestUpdatePermissions.isNotEmpty) {
      contactProfessionalEmail = getUpdatePermission('CONTATO_EMAIL_PROFISSIONAL');
      contactPhoneType = getUpdatePermission('CONTATO_TELEFONE_TIPO');
      contactPhoneDDI = getUpdatePermission('CONTATO_TELEFONE_DDI');
      contactPhoneDDD = getUpdatePermission('CONTATO_TELEFONE_DDD');
      contactPhoneNumber = getUpdatePermission('CONTATO_TELEFONE_NUMERO');
      contactPhoneExtension = getUpdatePermission('CONTATO_TELEFONE_RAMAL');
      contactPhoneProvider = getUpdatePermission('CONTATO_TELEFONE_OPERADORA');
      contactPhoneAction = getUpdatePermission('CONTATO_TELEFONE_ACAO');
      contactEmailType = getUpdatePermission('CONTATO_EMAIL_TIPO');
      contactEmailDescription = getUpdatePermission('CONTATO_EMAIL_DESCRICAO');
      contactEmailAction = getUpdatePermission('CONTATO_EMAIL_ACAO');
      contactSocialNetworkType = getUpdatePermission('CONTATO_REDE_SOCIAL_TIPO');
      contactSocialNetworkUsername = getUpdatePermission('CONTATO_REDE_SOCIAL_USUARIO');
      contactSocialNetworkAction = getUpdatePermission('CONTATO_REDE_SOCIAL_ACAO');
      contactNotes = getUpdatePermission('CONTATO_OBSERVACOES');
      contactPersonalEmail = getUpdatePermission('CONTATO_EMAIL_PESSOAL');
      personalDataName = getUpdatePermission('DADOS_PESSOAIS_NOME');
      personalDataBirthday = getUpdatePermission('DADOS_PESSOAIS_DATA_NASCIMENTO');
      personalDataGender = getUpdatePermission('DADOS_PESSOAIS_SEXO');
      personalDataMaritalStatus = getUpdatePermission('DADOS_PESSOAIS_ESTADO_CIVIL');
      personalDataNationality = getUpdatePermission('DADOS_PESSOAIS_NACIONALIDADE');
      personalDataBirthplace = getUpdatePermission('DADOS_PESSOAIS_NATURALIDADE');
      personalDataRace = getUpdatePermission('DADOS_PESSOAIS_RACA');
      personalDataEducationLevel = getUpdatePermission('DADOS_PESSOAIS_ESCOLARIDADE');
      personalDataDisability = getUpdatePermission('DADOS_PESSOAIS_DEFICIENCIA');
      personalDataNotes = getUpdatePermission('DADOS_PESSOAIS_OBSERVACOES');
      documentCpf = getUpdatePermission('DOCUMENTO_CPF_NUMERO');
      documentRgNumber = getUpdatePermission('DOCUMENTO_RG_NUMERO');
      documentRgIssuanceDate = getUpdatePermission('DOCUMENTO_RG_DATA_EXPEDICAO');
      documentRgIssuingBody = getUpdatePermission('DOCUMENTO_RG_ORGAO_EMISSOR');
      documentRgIssuingState = getUpdatePermission('DOCUMENTO_RG_UF_ORGAO_EMISSOR');
      documentVoterNumber = getUpdatePermission('DOCUMENTO_TITULO_NUMERO');
      documentVoterZone = getUpdatePermission('DOCUMENTO_TITULO_ZONA');
      documentVoterSection = getUpdatePermission('DOCUMENTO_TITULO_SECAO');
      documentCtpsIssuedDate = getUpdatePermission('DOCUMENTO_CTPS_DATA_EXPEDICAO');
      documentCtpsState = getUpdatePermission('DOCUMENTO_CTPS_UF');
      documentCtpsDigit = getUpdatePermission('DOCUMENTO_CTPS_DIGITO');
      documentCtpsSerie = getUpdatePermission('DOCUMENTO_CTPS_SERIE');
      documentCtpsNumber = getUpdatePermission('DOCUMENTO_CTPS_NUMERO');
      documentCnhNumber = getUpdatePermission('DOCUMENTO_CNH_NUMERO');
      documentCnhCategory = getUpdatePermission('DOCUMENTO_CNH_CATEGORIA');
      documentCnhIssuingBody = getUpdatePermission('DOCUMENTO_CNH_ORGAO_EMISSOR');
      documentCnhIssuingState = getUpdatePermission('DOCUMENTO_CNH_UF_ORGAO_EMISSOR');
      documentCnhIssuanceDate = getUpdatePermission('DOCUMENTO_CNH_DATA_EXPEDICAO');
      documentCnhFirstIssuedDate = getUpdatePermission('DOCUMENTO_CNH_DATA_PRIMEIRA_CNH');
      documentCnhExpiryDate = getUpdatePermission('DOCUMENTO_CNH_DATA_VALIDADE');
      documentRicNumber = getUpdatePermission('DOCUMENTO_RIC_NUMERO');
      documentRicIssuanceDate = getUpdatePermission('DOCUMENTO_RIC_DATA_EXPEDICAO');
      documentRicIssuingBody = getUpdatePermission('DOCUMENTO_RIC_ORGAO_EMISSOR');
      documentRicIssuingCity = getUpdatePermission('DOCUMENTO_RIC_CIDADE_EMISSAO');
      documentPassportNumber = getUpdatePermission('DOCUMENTO_PASSAPORTE_NUMERO');
      documentPassportCountry = getUpdatePermission('DOCUMENTO_PASSAPORTE_PAIS');
      documentPassportIssuingBody = getUpdatePermission('DOCUMENTO_PASSAPORTE_ORGAO_EMISSOR');
      documentPassportState = getUpdatePermission('DOCUMENTO_PASSAPORTE_UF_ORGAO_EMISSOR');
      documentPassportIssuanceDate = getUpdatePermission('DOCUMENTO_PASSAPORTE_DATA_EMISSAO');
      documentPassportExpiryDate = getUpdatePermission('DOCUMENTO_PASSAPORTE_DATA_VALIDADE');
      documentNisNumber = getUpdatePermission('DOCUMENTO_NIS_NUMERO');
      documentNisRegistrationDate = getUpdatePermission('DOCUMENTO_NIS_DATA');
      documentReservistNumber = getUpdatePermission('DOCUMENTO_RESERVISTA_NUMERO');
      documentReservistCategory = getUpdatePermission('DOCUMENTO_RESERVISTA_CATEGORIA');
      documentCnsNumber = getUpdatePermission('DOCUMENTO_CNS_NUMERO');
      documentCertificate = getUpdatePermission('DOCUMENTO_CERTIDOES');
      documentAttachment = getUpdatePermission('DOCUMENTO_COMPROVANTE');
      documentNotes = getUpdatePermission('DOCUMENTO_OBSERVACOES');
      documentVisaNumber = getUpdatePermission('DOCUMENTO_VISTO_NUMERO');
      documentVisaIssuedDate = getUpdatePermission('DOCUMENTO_VISTO_DATA_EMISSAO');
      documentVisaExpiryDate = getUpdatePermission('DOCUMENTO_VISTO_DATA_EXPIRA');
      documentVisaType = getUpdatePermission('DOCUMENTO_VISTO_TIPO');
      documentRneNumber = getUpdatePermission('DOCUMENTO_RNE_NUMERO');
      documentRneIssuingBody = getUpdatePermission('DOCUMENTO_RNE_ORGAO_EMISSOR');
      documentRneIssuedDate = getUpdatePermission('DOCUMENTO_RNE_DATA_EMISSAO');
      addressZipCode = getUpdatePermission('ENDERECO_CEP');
      addressPatioType = getUpdatePermission('ENDERECO_TIPO');
      addressPatio = getUpdatePermission('ENDERECO_LOGRADOURO');
      addressNumber = getUpdatePermission('ENDERECO_NUMERO');
      addressAdditional = getUpdatePermission('ENDERECO_COMPLEMENTO');
      addressNeighborhood = getUpdatePermission('ENDERECO_BAIRRO');
      addressCity = getUpdatePermission('ENDERECO_CIDADE');
      addressAdmRegion = getUpdatePermission('ENDERECO_REGIAO_ADMINISTRATIVA');
      addressNotes = getUpdatePermission('ENDERECO_OBSERVACOES');
      emergencyContactPhoneDDD = getUpdatePermission('CONTATO_EMERGENCIA_DDD');
      emergencyContactPhoneDDI = getUpdatePermission('CONTATO_EMERGENCIA_DDI');
      emergencyContactPhoneExtension = getUpdatePermission('CONTATO_EMERGENCIA_RAMAL');
      emergencyContactPhoneGender = getUpdatePermission('CONTATO_EMERGENCIA_SEXO');
      emergencyContactPhoneKinship = getUpdatePermission('CONTATO_EMERGENCIA_GRAU');
      emergencyContactPhoneName = getUpdatePermission('CONTATO_EMERGENCIA_NOME');
      emergencyContactPhoneNumber = getUpdatePermission('CONTATO_EMERGENCIA_NUMERO');
      emergencyContactPhoneProvider = getUpdatePermission('CONTATO_EMERGENCIA_OPERADORA');
    }

    return LegacyAuthorizationModel(
      allowToWriteFeedback: map['featureControl']['allowToWriteFeedback'] ?? false,
      allowToRequestFeedback: map['featureControl']['allowToRequestFeedback'] ?? false,
      shareFeedbacks: map['featureControl']['shareFeedbacks'] ?? false,
      feedbackEmployee: map['featureControl']['feedbackEmployee'] ?? false,
      feedbackEvaluator: map['featureControl']['feedbackEvaluator'] ?? false,
      feedbackLeader: map['featureControl']['feedbackLeader'] ?? false,
      feedbackOnlyEmployee: map['featureControl']['feedbackOnlyEmployee'] ?? false,
      allowEmployeeRequestVacation: map['vacationSettings']['allowEmployeeRequest'] ?? false,
      show13thSalaryAdvance: map['vacationSettings']['show13thSalaryAdvance'] ?? false,
      showBonusDays: map['vacationSettings']['showBonusDays'] ?? false,
      allowBonusDaysOnlyWhenThereIsBalance: map['vacationSettings']['allowBonusDaysOnlyWhenThereIsBalance'] ?? false,
      vacationHelpDescription: map['vacationSettings']['helpDescription'],
      allowToUpdateContactProfessionalEmail: contactProfessionalEmail,
      allowCancellationScheduledVacation: map['vacationSettings']['allowCancellationScheduledVacation'],
      allowToUpdatePersonalDataName: personalDataName,
      allowToUpdatePersonalDataBirthday: personalDataBirthday,
      allowToUpdatePersonalDataBirthplace: personalDataBirthplace,
      allowToUpdatePersonalDataDisability: personalDataDisability,
      allowToUpdatePersonalDataEducationLevel: personalDataEducationLevel,
      allowToUpdatePersonalDataGender: personalDataGender,
      allowToUpdatePersonalDataMaritalStatus: personalDataMaritalStatus,
      allowToUpdatePersonalDataNationality: personalDataNationality,
      allowToUpdatePersonalDataNotes: personalDataNotes,
      allowToUpdatePersonalDataRace: personalDataRace,
      allowToUpdateContactEmailAction: contactEmailAction,
      allowToUpdateContactEmailDescription: contactEmailDescription,
      allowToUpdateContactEmailType: contactEmailType,
      allowToUpdateContactNotes: contactNotes,
      allowToUpdateContactPersonalEmail: contactPersonalEmail,
      allowToUpdateContactPhoneAction: contactPhoneAction,
      allowToUpdateContactPhoneDDD: contactPhoneDDD,
      allowToUpdateContactPhoneDDI: contactPhoneDDI,
      allowToUpdateContactPhoneExtension: contactPhoneExtension,
      allowToUpdateContactPhoneNumber: contactPhoneNumber,
      allowToUpdateContactPhoneProvider: contactPhoneProvider,
      allowToUpdateContactPhoneType: contactPhoneType,
      allowToUpdateContactSocialNetworkAction: contactSocialNetworkAction,
      allowToUpdateContactSocialNetworkType: contactSocialNetworkType,
      allowToUpdateContactSocialNetworkUsername: contactSocialNetworkUsername,
      allowToUpdateDocumentCpf: documentCpf,
      allowToUpdateDocumentRgNumber: documentRgNumber,
      allowToUpdateDocumentRgIssuanceDate: documentRgIssuanceDate,
      allowToUpdateDocumentRgIssuingBody: documentRgIssuingBody,
      allowToUpdateDocumentRgIssuingState: documentRgIssuingState,
      allowToUpdateDocumentVoterNumber: documentVoterNumber,
      allowToUpdateDocumentVoterZone: documentVoterZone,
      allowToUpdateDocumentVoterSection: documentVoterSection,
      allowToUpdateDocumentCtpsIssuedDate: documentCtpsIssuedDate,
      allowToUpdateDocumentCtpsState: documentCtpsState,
      allowToUpdateDocumentCtpsDigit: documentCtpsDigit,
      allowToUpdateDocumentCtpsSerie: documentCtpsSerie,
      allowToUpdateDocumentCtpsNumber: documentCtpsNumber,
      allowToUpdateDocumentCnhNumber: documentCnhNumber,
      allowToUpdateDocumentCnhCategory: documentCnhCategory,
      allowToUpdateDocumentCnhIssuingBody: documentCnhIssuingBody,
      allowToUpdateDocumentCnhIssuingState: documentCnhIssuingState,
      allowToUpdateDocumentCnhIssuanceDate: documentCnhIssuanceDate,
      allowToUpdateDocumentCnhFirstIssuedDate: documentCnhFirstIssuedDate,
      allowToUpdateDocumentCnhExpiryDate: documentCnhExpiryDate,
      allowToUpdateDocumentRicNumber: documentRicNumber,
      allowToUpdateDocumentRicIssuanceDate: documentRicIssuanceDate,
      allowToUpdateDocumentRicIssuingBody: documentRicIssuingBody,
      allowToUpdateDocumentRicIssuingCity: documentRicIssuingCity,
      allowToUpdateDocumentPassportNumber: documentPassportNumber,
      allowToUpdateDocumentPassportCountry: documentPassportCountry,
      allowToUpdateDocumentPassportIssuingBody: documentPassportIssuingBody,
      allowToUpdateDocumentPassportState: documentPassportState,
      allowToUpdateDocumentPassportIssuanceDate: documentPassportIssuanceDate,
      allowToUpdateDocumentPassportExpiryDate: documentPassportExpiryDate,
      allowToUpdateDocumentNisNumber: documentNisNumber,
      allowToUpdateDocumentNisRegistrationDate: documentNisRegistrationDate,
      allowToUpdateDocumentReservistNumber: documentReservistNumber,
      allowToUpdateDocumentReservistCategory: documentReservistCategory,
      allowToUpdateDocumentCnsNumber: documentCnsNumber,
      allowToUpdateDocumentCertificate: documentCertificate,
      allowToUpdateDocumentAttachment: documentAttachment,
      allowToUpdateDocumentNotes: documentNotes,
      allowToUpdateDocumentVisaNumber: documentVisaNumber,
      allowToUpdateDocumentVisaIssuedDate: documentVisaIssuedDate,
      allowToUpdateDocumentVisaExpiryDate: documentVisaExpiryDate,
      allowToUpdateDocumentVisaType: documentVisaType,
      allowToUpdateDocumentRneNumber: documentRneNumber,
      allowToUpdateDocumentRneIssuingBody: documentRneIssuingBody,
      allowToUpdateDocumentRneIssuedDate: documentRneIssuedDate,
      allowToUpdateAddressAdditional: addressAdditional,
      allowToUpdateAddressAdmRegion: addressAdmRegion,
      allowToUpdateAddressCity: addressCity,
      allowToUpdateAddressNeighborhood: addressNeighborhood,
      allowToUpdateAddressNotes: addressNotes,
      allowToUpdateAddressNumber: addressNumber,
      allowToUpdateAddressPatio: addressPatio,
      allowToUpdateAddressPatioType: addressPatioType,
      allowToUpdateAddressZipCode: addressZipCode,
      allowToUpdateEmergencyContactPhoneDDD: emergencyContactPhoneDDD,
      allowToUpdateEmergencyContactPhoneDDI: emergencyContactPhoneDDI,
      allowToUpdateEmergencyContactPhoneExtension: emergencyContactPhoneExtension,
      allowToUpdateEmergencyContactPhoneGender: emergencyContactPhoneGender,
      allowToUpdateEmergencyContactPhoneKinship: emergencyContactPhoneKinship,
      allowToUpdateEmergencyContactPhoneName: emergencyContactPhoneName,
      allowToUpdateEmergencyContactPhoneNumber: emergencyContactPhoneNumber,
      allowToUpdateEmergencyContactPhoneProvider: emergencyContactPhoneProvider,
    );
  }

  LegacyAuthorizationModel fromJson({
    required String json,
  }) {
    return fromMap(
      map: jsonDecode(json),
    );
  }

  bool getUpdatePermission(String key) {
    return (requestUpdatePermissions.where((e) => e['key'] == key).isNotEmpty)
        ? requestUpdatePermissions.where((e) => e['key'] == key).first['value'] ?? false
        : false;
  }
}
