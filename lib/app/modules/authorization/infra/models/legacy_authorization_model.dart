import 'package:equatable/equatable.dart';

class LegacyAuthorizationModel extends Equatable {
  final bool allowToWriteFeedback;
  final bool allowToRequestFeedback;
  final bool shareFeedbacks;
  final bool feedbackEmployee;
  final bool feedbackEvaluator;
  final bool feedbackLeader;
  final bool feedbackOnlyEmployee;
  final bool allowEmployeeRequestVacation;
  final bool show13thSalaryAdvance;
  final bool showBonusDays;
  final bool allowBonusDaysOnlyWhenThereIsBalance;
  final String? vacationHelpDescription;
  final bool allowCancellationScheduledVacation;
  final bool allowToUpdateContactProfessionalEmail;
  final bool allowToUpdateContactPersonalEmail;
  final bool allowToUpdateContactPhoneType;
  final bool allowToUpdateContactPhoneDDI;
  final bool allowToUpdateContactPhoneDDD;
  final bool allowToUpdateContactPhoneNumber;
  final bool allowToUpdateContactPhoneExtension;
  final bool allowToUpdateContactPhoneProvider;
  final bool allowToUpdateContactPhoneAction;
  final bool allowToUpdateContactEmailType;
  final bool allowToUpdateContactEmailDescription;
  final bool allowToUpdateContactEmailAction;
  final bool allowToUpdateContactSocialNetworkType;
  final bool allowToUpdateContactSocialNetworkUsername;
  final bool allowToUpdateContactSocialNetworkAction;
  final bool allowToUpdateContactNotes;
  final bool allowToUpdatePersonalDataName;
  final bool allowToUpdatePersonalDataNationality;
  final bool allowToUpdatePersonalDataDisability;
  final bool allowToUpdatePersonalDataRace;
  final bool allowToUpdatePersonalDataBirthday;
  final bool allowToUpdatePersonalDataNotes;
  final bool allowToUpdatePersonalDataBirthplace;
  final bool allowToUpdatePersonalDataEducationLevel;
  final bool allowToUpdatePersonalDataMaritalStatus;
  final bool allowToUpdatePersonalDataGender;
  final bool allowToUpdateDocumentCpf;
  final bool allowToUpdateDocumentRgNumber;
  final bool allowToUpdateDocumentRgIssuanceDate;
  final bool allowToUpdateDocumentRgIssuingBody;
  final bool allowToUpdateDocumentRgIssuingState;
  final bool allowToUpdateDocumentVoterNumber;
  final bool allowToUpdateDocumentVoterZone;
  final bool allowToUpdateDocumentVoterSection;
  final bool allowToUpdateDocumentCtpsIssuedDate;
  final bool allowToUpdateDocumentCtpsState;
  final bool allowToUpdateDocumentCtpsDigit;
  final bool allowToUpdateDocumentCtpsSerie;
  final bool allowToUpdateDocumentCtpsNumber;
  final bool allowToUpdateDocumentCnhNumber;
  final bool allowToUpdateDocumentCnhCategory;
  final bool allowToUpdateDocumentCnhIssuingBody;
  final bool allowToUpdateDocumentCnhIssuingState;
  final bool allowToUpdateDocumentCnhIssuanceDate;
  final bool allowToUpdateDocumentCnhFirstIssuedDate;
  final bool allowToUpdateDocumentCnhExpiryDate;
  final bool allowToUpdateDocumentRicNumber;
  final bool allowToUpdateDocumentRicIssuanceDate;
  final bool allowToUpdateDocumentRicIssuingBody;
  final bool allowToUpdateDocumentRicIssuingCity;
  final bool allowToUpdateDocumentPassportNumber;
  final bool allowToUpdateDocumentPassportCountry;
  final bool allowToUpdateDocumentPassportIssuingBody;
  final bool allowToUpdateDocumentPassportState;
  final bool allowToUpdateDocumentPassportIssuanceDate;
  final bool allowToUpdateDocumentPassportExpiryDate;
  final bool allowToUpdateDocumentNisNumber;
  final bool allowToUpdateDocumentNisRegistrationDate;
  final bool allowToUpdateDocumentReservistNumber;
  final bool allowToUpdateDocumentReservistCategory;
  final bool allowToUpdateDocumentCnsNumber;
  final bool allowToUpdateDocumentCertificate;
  final bool allowToUpdateDocumentAttachment;
  final bool allowToUpdateDocumentNotes;
  final bool allowToUpdateDocumentVisaNumber;
  final bool allowToUpdateDocumentVisaIssuedDate;
  final bool allowToUpdateDocumentVisaExpiryDate;
  final bool allowToUpdateDocumentVisaType;
  final bool allowToUpdateDocumentRneNumber;
  final bool allowToUpdateDocumentRneIssuingBody;
  final bool allowToUpdateDocumentRneIssuedDate;
  final bool allowToUpdateAddressZipCode;
  final bool allowToUpdateAddressPatioType;
  final bool allowToUpdateAddressPatio;
  final bool allowToUpdateAddressNumber;
  final bool allowToUpdateAddressAdditional;
  final bool allowToUpdateAddressNeighborhood;
  final bool allowToUpdateAddressCity;
  final bool allowToUpdateAddressAdmRegion;
  final bool allowToUpdateAddressNotes;
  final bool allowToUpdateEmergencyContactPhoneDDI;
  final bool allowToUpdateEmergencyContactPhoneDDD;
  final bool allowToUpdateEmergencyContactPhoneNumber;
  final bool allowToUpdateEmergencyContactPhoneExtension;
  final bool allowToUpdateEmergencyContactPhoneProvider;
  final bool allowToUpdateEmergencyContactPhoneKinship;
  final bool allowToUpdateEmergencyContactPhoneName;
  final bool allowToUpdateEmergencyContactPhoneGender;

  const LegacyAuthorizationModel({
    required this.allowToWriteFeedback,
    required this.allowToRequestFeedback,
    required this.shareFeedbacks,
    required this.feedbackEmployee,
    required this.feedbackEvaluator,
    required this.feedbackLeader,
    required this.feedbackOnlyEmployee,
    required this.allowEmployeeRequestVacation,
    required this.show13thSalaryAdvance,
    required this.showBonusDays,
    required this.allowBonusDaysOnlyWhenThereIsBalance,
    required this.vacationHelpDescription,
    required this.allowCancellationScheduledVacation,
    required this.allowToUpdateContactProfessionalEmail,
    required this.allowToUpdatePersonalDataName,
    required this.allowToUpdatePersonalDataNationality,
    required this.allowToUpdatePersonalDataDisability,
    required this.allowToUpdatePersonalDataRace,
    required this.allowToUpdatePersonalDataBirthday,
    required this.allowToUpdatePersonalDataNotes,
    required this.allowToUpdatePersonalDataBirthplace,
    required this.allowToUpdatePersonalDataEducationLevel,
    required this.allowToUpdatePersonalDataMaritalStatus,
    required this.allowToUpdatePersonalDataGender,
    required this.allowToUpdateContactPersonalEmail,
    required this.allowToUpdateContactPhoneType,
    required this.allowToUpdateContactPhoneDDI,
    required this.allowToUpdateContactPhoneDDD,
    required this.allowToUpdateContactPhoneNumber,
    required this.allowToUpdateContactPhoneExtension,
    required this.allowToUpdateContactPhoneProvider,
    required this.allowToUpdateContactPhoneAction,
    required this.allowToUpdateContactEmailType,
    required this.allowToUpdateContactEmailDescription,
    required this.allowToUpdateContactEmailAction,
    required this.allowToUpdateContactSocialNetworkType,
    required this.allowToUpdateContactSocialNetworkUsername,
    required this.allowToUpdateContactSocialNetworkAction,
    required this.allowToUpdateContactNotes,
    required this.allowToUpdateDocumentCpf,
    required this.allowToUpdateDocumentRgNumber,
    required this.allowToUpdateDocumentRgIssuanceDate,
    required this.allowToUpdateDocumentRgIssuingBody,
    required this.allowToUpdateDocumentRgIssuingState,
    required this.allowToUpdateDocumentVoterNumber,
    required this.allowToUpdateDocumentVoterZone,
    required this.allowToUpdateDocumentVoterSection,
    required this.allowToUpdateDocumentCtpsIssuedDate,
    required this.allowToUpdateDocumentCtpsState,
    required this.allowToUpdateDocumentCtpsDigit,
    required this.allowToUpdateDocumentCtpsSerie,
    required this.allowToUpdateDocumentCtpsNumber,
    required this.allowToUpdateDocumentCnhNumber,
    required this.allowToUpdateDocumentCnhCategory,
    required this.allowToUpdateDocumentCnhIssuingBody,
    required this.allowToUpdateDocumentCnhIssuingState,
    required this.allowToUpdateDocumentCnhIssuanceDate,
    required this.allowToUpdateDocumentCnhFirstIssuedDate,
    required this.allowToUpdateDocumentCnhExpiryDate,
    required this.allowToUpdateDocumentRicNumber,
    required this.allowToUpdateDocumentRicIssuanceDate,
    required this.allowToUpdateDocumentRicIssuingBody,
    required this.allowToUpdateDocumentRicIssuingCity,
    required this.allowToUpdateDocumentPassportNumber,
    required this.allowToUpdateDocumentPassportCountry,
    required this.allowToUpdateDocumentPassportIssuingBody,
    required this.allowToUpdateDocumentPassportState,
    required this.allowToUpdateDocumentPassportIssuanceDate,
    required this.allowToUpdateDocumentPassportExpiryDate,
    required this.allowToUpdateDocumentNisNumber,
    required this.allowToUpdateDocumentNisRegistrationDate,
    required this.allowToUpdateDocumentReservistNumber,
    required this.allowToUpdateDocumentReservistCategory,
    required this.allowToUpdateDocumentCnsNumber,
    required this.allowToUpdateDocumentCertificate,
    required this.allowToUpdateDocumentAttachment,
    required this.allowToUpdateDocumentNotes,
    required this.allowToUpdateDocumentVisaNumber,
    required this.allowToUpdateDocumentVisaIssuedDate,
    required this.allowToUpdateDocumentVisaExpiryDate,
    required this.allowToUpdateDocumentVisaType,
    required this.allowToUpdateDocumentRneNumber,
    required this.allowToUpdateDocumentRneIssuingBody,
    required this.allowToUpdateDocumentRneIssuedDate,
    required this.allowToUpdateAddressZipCode,
    required this.allowToUpdateAddressPatioType,
    required this.allowToUpdateAddressPatio,
    required this.allowToUpdateAddressNumber,
    required this.allowToUpdateAddressAdditional,
    required this.allowToUpdateAddressNeighborhood,
    required this.allowToUpdateAddressCity,
    required this.allowToUpdateAddressAdmRegion,
    required this.allowToUpdateAddressNotes,
    required this.allowToUpdateEmergencyContactPhoneDDI,
    required this.allowToUpdateEmergencyContactPhoneDDD,
    required this.allowToUpdateEmergencyContactPhoneNumber,
    required this.allowToUpdateEmergencyContactPhoneExtension,
    required this.allowToUpdateEmergencyContactPhoneProvider,
    required this.allowToUpdateEmergencyContactPhoneKinship,
    required this.allowToUpdateEmergencyContactPhoneName,
    required this.allowToUpdateEmergencyContactPhoneGender,
  });

  factory LegacyAuthorizationModel.empty() {
    return const LegacyAuthorizationModel(
      allowToWriteFeedback: false,
      allowToRequestFeedback: false,
      shareFeedbacks: false,
      feedbackEmployee: false,
      feedbackEvaluator: false,
      feedbackLeader: false,
      feedbackOnlyEmployee: false,
      allowEmployeeRequestVacation: false,
      show13thSalaryAdvance: false,
      showBonusDays: false,
      allowBonusDaysOnlyWhenThereIsBalance: false,
      vacationHelpDescription: null,
      allowCancellationScheduledVacation: false,
      allowToUpdatePersonalDataBirthday: false,
      allowToUpdatePersonalDataBirthplace: false,
      allowToUpdatePersonalDataDisability: false,
      allowToUpdatePersonalDataEducationLevel: false,
      allowToUpdatePersonalDataGender: false,
      allowToUpdatePersonalDataMaritalStatus: false,
      allowToUpdatePersonalDataNationality: false,
      allowToUpdatePersonalDataName: false,
      allowToUpdatePersonalDataNotes: false,
      allowToUpdatePersonalDataRace: false,
      allowToUpdateContactProfessionalEmail: false,
      allowToUpdateContactPersonalEmail: false,
      allowToUpdateContactEmailAction: false,
      allowToUpdateContactEmailDescription: false,
      allowToUpdateContactEmailType: false,
      allowToUpdateContactNotes: false,
      allowToUpdateContactPhoneAction: false,
      allowToUpdateContactPhoneDDD: false,
      allowToUpdateContactPhoneDDI: false,
      allowToUpdateContactPhoneExtension: false,
      allowToUpdateContactPhoneNumber: false,
      allowToUpdateContactPhoneProvider: false,
      allowToUpdateContactPhoneType: false,
      allowToUpdateContactSocialNetworkAction: false,
      allowToUpdateContactSocialNetworkType: false,
      allowToUpdateContactSocialNetworkUsername: false,
      allowToUpdateDocumentCpf: false,
      allowToUpdateDocumentRgNumber: false,
      allowToUpdateDocumentRgIssuanceDate: false,
      allowToUpdateDocumentRgIssuingBody: false,
      allowToUpdateDocumentRgIssuingState: false,
      allowToUpdateDocumentVoterNumber: false,
      allowToUpdateDocumentVoterZone: false,
      allowToUpdateDocumentVoterSection: false,
      allowToUpdateDocumentCtpsIssuedDate: false,
      allowToUpdateDocumentCtpsState: false,
      allowToUpdateDocumentCtpsDigit: false,
      allowToUpdateDocumentCtpsSerie: false,
      allowToUpdateDocumentCtpsNumber: false,
      allowToUpdateDocumentCnhNumber: false,
      allowToUpdateDocumentCnhCategory: false,
      allowToUpdateDocumentCnhIssuingBody: false,
      allowToUpdateDocumentCnhIssuingState: false,
      allowToUpdateDocumentCnhIssuanceDate: false,
      allowToUpdateDocumentCnhFirstIssuedDate: false,
      allowToUpdateDocumentCnhExpiryDate: false,
      allowToUpdateDocumentRicNumber: false,
      allowToUpdateDocumentRicIssuanceDate: false,
      allowToUpdateDocumentRicIssuingBody: false,
      allowToUpdateDocumentRicIssuingCity: false,
      allowToUpdateDocumentPassportNumber: false,
      allowToUpdateDocumentPassportCountry: false,
      allowToUpdateDocumentPassportIssuingBody: false,
      allowToUpdateDocumentPassportState: false,
      allowToUpdateDocumentPassportIssuanceDate: false,
      allowToUpdateDocumentPassportExpiryDate: false,
      allowToUpdateDocumentNisNumber: false,
      allowToUpdateDocumentNisRegistrationDate: false,
      allowToUpdateDocumentReservistNumber: false,
      allowToUpdateDocumentReservistCategory: false,
      allowToUpdateDocumentCnsNumber: false,
      allowToUpdateDocumentCertificate: false,
      allowToUpdateDocumentAttachment: false,
      allowToUpdateDocumentNotes: false,
      allowToUpdateDocumentVisaNumber: false,
      allowToUpdateDocumentVisaIssuedDate: false,
      allowToUpdateDocumentVisaExpiryDate: false,
      allowToUpdateDocumentVisaType: false,
      allowToUpdateDocumentRneNumber: false,
      allowToUpdateDocumentRneIssuingBody: false,
      allowToUpdateDocumentRneIssuedDate: false,
      allowToUpdateAddressAdditional: false,
      allowToUpdateAddressAdmRegion: false,
      allowToUpdateAddressCity: false,
      allowToUpdateAddressNeighborhood: false,
      allowToUpdateAddressNotes: false,
      allowToUpdateAddressNumber: false,
      allowToUpdateAddressPatio: false,
      allowToUpdateAddressPatioType: false,
      allowToUpdateAddressZipCode: false,
      allowToUpdateEmergencyContactPhoneDDD: false,
      allowToUpdateEmergencyContactPhoneDDI: false,
      allowToUpdateEmergencyContactPhoneExtension: false,
      allowToUpdateEmergencyContactPhoneGender: false,
      allowToUpdateEmergencyContactPhoneKinship: false,
      allowToUpdateEmergencyContactPhoneName: false,
      allowToUpdateEmergencyContactPhoneNumber: false,
      allowToUpdateEmergencyContactPhoneProvider: false,
    );
  }

  @override
  List<Object?> get props {
    return [
      allowToWriteFeedback,
      allowToRequestFeedback,
      shareFeedbacks,
      feedbackEmployee,
      feedbackEvaluator,
      feedbackLeader,
      feedbackOnlyEmployee,
      allowEmployeeRequestVacation,
      show13thSalaryAdvance,
      showBonusDays,
      allowBonusDaysOnlyWhenThereIsBalance,
      vacationHelpDescription,
      allowToUpdateContactProfessionalEmail,
      allowCancellationScheduledVacation,
      allowToUpdatePersonalDataName,
      allowToUpdatePersonalDataNationality,
      allowToUpdatePersonalDataDisability,
      allowToUpdatePersonalDataRace,
      allowToUpdatePersonalDataBirthday,
      allowToUpdatePersonalDataNotes,
      allowToUpdatePersonalDataBirthplace,
      allowToUpdatePersonalDataEducationLevel,
      allowToUpdatePersonalDataMaritalStatus,
      allowToUpdatePersonalDataGender,
      allowToUpdateContactPersonalEmail,
      allowToUpdateContactEmailAction,
      allowToUpdateContactEmailDescription,
      allowToUpdateContactEmailType,
      allowToUpdateContactNotes,
      allowToUpdateContactPhoneAction,
      allowToUpdateContactPhoneDDD,
      allowToUpdateContactPhoneDDI,
      allowToUpdateContactPhoneExtension,
      allowToUpdateContactPhoneNumber,
      allowToUpdateContactPhoneProvider,
      allowToUpdateContactPhoneType,
      allowToUpdateContactSocialNetworkAction,
      allowToUpdateContactSocialNetworkType,
      allowToUpdateContactSocialNetworkUsername,
      allowToUpdateDocumentCpf,
      allowToUpdateDocumentRgNumber,
      allowToUpdateDocumentRgIssuanceDate,
      allowToUpdateDocumentRgIssuingBody,
      allowToUpdateDocumentRgIssuingState,
      allowToUpdateDocumentVoterNumber,
      allowToUpdateDocumentVoterZone,
      allowToUpdateDocumentVoterSection,
      allowToUpdateDocumentCtpsIssuedDate,
      allowToUpdateDocumentCtpsState,
      allowToUpdateDocumentCtpsDigit,
      allowToUpdateDocumentCtpsSerie,
      allowToUpdateDocumentCtpsNumber,
      allowToUpdateDocumentCnhNumber,
      allowToUpdateDocumentCnhCategory,
      allowToUpdateDocumentCnhIssuingBody,
      allowToUpdateDocumentCnhIssuingState,
      allowToUpdateDocumentCnhIssuanceDate,
      allowToUpdateDocumentCnhFirstIssuedDate,
      allowToUpdateDocumentCnhExpiryDate,
      allowToUpdateDocumentRicNumber,
      allowToUpdateDocumentRicIssuanceDate,
      allowToUpdateDocumentRicIssuingBody,
      allowToUpdateDocumentRicIssuingCity,
      allowToUpdateDocumentPassportNumber,
      allowToUpdateDocumentPassportCountry,
      allowToUpdateDocumentPassportIssuingBody,
      allowToUpdateDocumentPassportState,
      allowToUpdateDocumentPassportIssuanceDate,
      allowToUpdateDocumentPassportExpiryDate,
      allowToUpdateDocumentNisNumber,
      allowToUpdateDocumentNisRegistrationDate,
      allowToUpdateDocumentReservistNumber,
      allowToUpdateDocumentReservistCategory,
      allowToUpdateDocumentCnsNumber,
      allowToUpdateDocumentCertificate,
      allowToUpdateDocumentAttachment,
      allowToUpdateDocumentNotes,
      allowToUpdateDocumentVisaNumber,
      allowToUpdateDocumentVisaIssuedDate,
      allowToUpdateDocumentVisaExpiryDate,
      allowToUpdateDocumentVisaType,
      allowToUpdateDocumentRneNumber,
      allowToUpdateDocumentRneIssuingBody,
      allowToUpdateDocumentRneIssuedDate,
      allowToUpdateAddressZipCode,
      allowToUpdateAddressPatioType,
      allowToUpdateAddressPatio,
      allowToUpdateAddressNumber,
      allowToUpdateAddressAdditional,
      allowToUpdateAddressNeighborhood,
      allowToUpdateAddressCity,
      allowToUpdateAddressAdmRegion,
      allowToUpdateAddressNotes,
      allowToUpdateEmergencyContactPhoneDDD,
      allowToUpdateEmergencyContactPhoneDDI,
      allowToUpdateEmergencyContactPhoneExtension,
      allowToUpdateEmergencyContactPhoneGender,
      allowToUpdateEmergencyContactPhoneKinship,
      allowToUpdateEmergencyContactPhoneName,
      allowToUpdateEmergencyContactPhoneNumber,
      allowToUpdateEmergencyContactPhoneProvider,
    ];
  }
}
