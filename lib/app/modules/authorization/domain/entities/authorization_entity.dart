import 'package:equatable/equatable.dart';

import 'social_authorization_entity.dart';

class AuthorizationEntity extends Equatable {
  final bool _allowToViewMyFeedbacks;
  final bool _allowToViewMyFeedbacksRequests;
  final bool _allowToWriteFeedback;
  final bool _allowToRequestFeedback;
  final bool _allowToToggleInternalFeedbackSharing;
  final bool _allowToMakeFeedbackVisibleToEmployeeAndManager;
  final bool _allowToMakeFeedbackVisibleToEvaluator;
  final bool _allowToMakeFeedbackVisibleToManager;
  final bool _allowToMakeFeedbackVisibleToEmployee;
  final bool _allowToViewMyProfile;
  final bool _allowToViewVacations;
  final bool _allowToSearchPeople;
  final bool _allowToViewBirthdayCorporateMural;
  final bool _allowToViewCompanyBirthdayCorporateMural;
  final bool _allowToViewVacationAnalytics;
  final bool _allowEmployeeRequestVacation;
  final bool _show13thSalaryAdvance;
  final bool _showBonusDays;
  final bool _allowBonusDaysOnlyWhenThereIsBalance;
  final String? _vacationHelpDescription;
  final bool _allowCancellationScheduledVacation;
  final bool _allowToUpdatePersonalData;
  final bool _allowToUpdateEmergencyContact;
  final bool _allowToUpdatePersonalAddress;
  final bool _allowToUpdatePersonalContact;
  final bool _allowToUpdateContactProfessionalEmail;
  final bool _allowToUpdateContactPersonalEmail;
  final bool _allowToUpdateContactPhoneType;
  final bool _allowToUpdateContactPhoneDDI;
  final bool _allowToUpdateContactPhoneDDD;
  final bool _allowToUpdateContactPhoneNumber;
  final bool _allowToUpdateContactPhoneExtension;
  final bool _allowToUpdateContactPhoneProvider;
  final bool _allowToUpdateContactPhoneAction;
  final bool _allowToUpdateContactEmailType;
  final bool _allowToUpdateContactEmailDescription;
  final bool _allowToUpdateContactEmailAction;
  final bool _allowToUpdateContactSocialNetworkType;
  final bool _allowToUpdateContactSocialNetworkUsername;
  final bool _allowToUpdateContactSocialNetworkAction;
  final bool _allowToUpdateContactNotes;
  final bool _allowToUpdatePersonalDocuments;
  final bool _allowToViewCalendarVacations;
  final bool _allowToViewTimeManagement;
  final bool _allowToViewClockingMobileLog;
  final bool _allowToFinancialData;
  final bool _allowToUpdatePersonalDependents;
  final bool _allowToViewDependents;
  final bool _enableDependentIncomeTax;
  final bool _allowToPayroll;
  final bool _enablePersonalPhoto;
  final bool _allowToUpdatePersonalDataName;
  final bool _allowToUpdatePersonalDataNationality;
  final bool _allowToUpdatePersonalDataDisability;
  final bool _allowToUpdatePersonalDataRace;
  final bool _allowToUpdatePersonalDataBirthday;
  final bool _allowToUpdatePersonalDataNotes;
  final bool _allowToUpdatePersonalDataBirthplace;
  final bool _allowToUpdatePersonalDataEducationLevel;
  final bool _allowToUpdatePersonalDataMaritalStatus;
  final bool _allowToUpdatePersonalDataGender;
  final bool _allowToUpdateAddressZipCode;
  final bool _allowToUpdateAddressPatioType;
  final bool _allowToUpdateAddressPatio;
  final bool _allowToUpdateAddressNumber;
  final bool _allowToUpdateAddressAdditional;
  final bool _allowToUpdateAddressNeighborhood;
  final bool _allowToUpdateAddressCity;
  final bool _allowToUpdateAddressAdmRegion;
  final bool _allowToUpdateAddressNotes;
  final bool _allowToUpdateDocumentCpf;
  final bool _allowToUpdateDocumentRgNumber;
  final bool _allowToUpdateDocumentRgIssuanceDate;
  final bool _allowToUpdateDocumentRgIssuingBody;
  final bool _allowToUpdateDocumentRgIssuingState;
  final bool _allowToUpdateDocumentVoterNumber;
  final bool _allowToUpdateDocumentVoterZone;
  final bool _allowToUpdateDocumentVoterSection;
  final bool _allowToUpdateDocumentCtpsIssuedDate;
  final bool _allowToUpdateDocumentCtpsState;
  final bool _allowToUpdateDocumentCtpsDigit;
  final bool _allowToUpdateDocumentCtpsSerie;
  final bool _allowToUpdateDocumentCtpsNumber;
  final bool _allowToUpdateDocumentCnhNumber;
  final bool _allowToUpdateDocumentCnhCategory;
  final bool _allowToUpdateDocumentCnhIssuingBody;
  final bool _allowToUpdateDocumentCnhIssuingState;
  final bool _allowToUpdateDocumentCnhIssuanceDate;
  final bool _allowToUpdateDocumentCnhFirstIssuedDate;
  final bool _allowToUpdateDocumentCnhExpiryDate;
  final bool _allowToUpdateDocumentRicNumber;
  final bool _allowToUpdateDocumentRicIssuanceDate;
  final bool _allowToUpdateDocumentRicIssuingBody;
  final bool _allowToUpdateDocumentRicIssuingCity;
  final bool _allowToUpdateDocumentPassportNumber;
  final bool _allowToUpdateDocumentPassportCountry;
  final bool _allowToUpdateDocumentPassportIssuingBody;
  final bool _allowToUpdateDocumentPassportState;
  final bool _allowToUpdateDocumentPassportIssuanceDate;
  final bool _allowToUpdateDocumentPassportExpiryDate;
  final bool _allowToUpdateDocumentNisNumber;
  final bool _allowToUpdateDocumentNisRegistrationDate;
  final bool _allowToUpdateDocumentReservistNumber;
  final bool _allowToUpdateDocumentReservistCategory;
  final bool _allowToUpdateDocumentCnsNumber;
  final bool _allowToUpdateDocumentCertificate;
  final bool _allowToUpdateDocumentAttachment;
  final bool _allowToUpdateDocumentNotes;
  final bool _allowToUpdateDocumentVisaNumber;
  final bool _allowToUpdateDocumentVisaIssuedDate;
  final bool _allowToUpdateDocumentVisaExpiryDate;
  final bool _allowToUpdateDocumentVisaType;
  final bool _allowToUpdateDocumentRneNumber;
  final bool _allowToUpdateDocumentRneIssuingBody;
  final bool _allowToUpdateDocumentRneIssuedDate;
  final bool _allowToUpdateEmergencyContactPhoneDDI;
  final bool _allowToUpdateEmergencyContactPhoneDDD;
  final bool _allowToUpdateEmergencyContactPhoneNumber;
  final bool _allowToUpdateEmergencyContactPhoneExtension;
  final bool _allowToUpdateEmergencyContactPhoneProvider;
  final bool _allowToUpdateEmergencyContactPhoneKinship;
  final bool _allowToUpdateEmergencyContactPhoneName;
  final bool _allowToUpdateEmergencyContactPhoneGender;
  final bool _allowToViewVacationSignature;
  final bool _allowToViewHyperlinks;
  final SocialAuthorizationEntity _socialAuthorizationEntity;
  final bool _isWaapiLite;
  final bool _allowToViewDiversity;
  final bool _allowToViewWorkContract;

  const AuthorizationEntity({
    required bool allowToViewMyFeedbacks,
    required bool allowToViewMyFeedbacksRequests,
    required bool allowToWriteFeedback,
    required bool allowToRequestFeedback,
    required bool allowToToggleInternalFeedbackSharing,
    required bool allowToMakeFeedbackVisibleToEmployeeAndManager,
    required bool allowToMakeFeedbackVisibleToEvaluator,
    required bool allowToMakeFeedbackVisibleToManager,
    required bool allowToMakeFeedbackVisibleToEmployee,
    required bool allowToViewMyProfile,
    required bool allowToViewVacations,
    required bool allowToSearchPeople,
    required bool allowToViewBirthdayCorporateMural,
    required bool allowToViewCompanyBirthdayCorporateMural,
    required bool allowToViewVacationAnalytics,
    required bool allowEmployeeRequestVacation,
    required bool show13thSalaryAdvance,
    required bool showBonusDays,
    required bool allowBonusDaysOnlyWhenThereIsBalance,
    required String? vacationHelpDescription,
    required bool allowCancellationScheduledVacation,
    required bool allowToUpdatePersonalData,
    required bool allowToUpdateEmergencyContact,
    required bool allowToUpdatePersonalAddress,
    required bool allowToUpdatePersonalContact,
    required bool allowToUpdatePersonalDocuments,
    required bool allowToViewCalendarVacations,
    required bool allowToViewTimeManagement,
    required bool allowToViewClockingMobileLog,
    required bool allowToFinancialData,
    required bool allowToUpdatePersonalDependents,
    required bool allowToViewDependents,
    required bool enableDependentIncomeTax,
    required bool enablePersonalPhoto,
    required bool allowToPayroll,
    required bool allowToUpdatePersonalDataName,
    required bool allowToUpdatePersonalDataNationality,
    required bool allowToUpdatePersonalDataDisability,
    required bool allowToUpdatePersonalDataRace,
    required bool allowToUpdatePersonalDataBirthday,
    required bool allowToUpdatePersonalDataNotes,
    required bool allowToUpdatePersonalDataBirthplace,
    required bool allowToUpdatePersonalDataEducationLevel,
    required bool allowToUpdatePersonalDataMaritalStatus,
    required bool allowToUpdatePersonalDataGender,
    required bool allowToUpdateContactProfessionalEmail,
    required bool allowToUpdateContactPersonalEmail,
    required bool allowToUpdateContactPhoneType,
    required bool allowToUpdateContactPhoneDDI,
    required bool allowToUpdateContactPhoneDDD,
    required bool allowToUpdateContactPhoneNumber,
    required bool allowToUpdateContactPhoneExtension,
    required bool allowToUpdateContactPhoneProvider,
    required bool allowToUpdateContactPhoneAction,
    required bool allowToUpdateContactEmailType,
    required bool allowToUpdateContactEmailDescription,
    required bool allowToUpdateContactEmailAction,
    required bool allowToUpdateContactSocialNetworkType,
    required bool allowToUpdateContactSocialNetworkUsername,
    required bool allowToUpdateContactSocialNetworkAction,
    required bool allowToUpdateContactNotes,
    required bool allowToUpdateAddressZipCode,
    required bool allowToUpdateAddressPatioType,
    required bool allowToUpdateAddressPatio,
    required bool allowToUpdateAddressNumber,
    required bool allowToUpdateAddressAdditional,
    required bool allowToUpdateAddressNeighborhood,
    required bool allowToUpdateAddressCity,
    required bool allowToUpdateAddressAdmRegion,
    required bool allowToUpdateAddressNotes,
    required bool allowToUpdateDocumentCpf,
    required bool allowToUpdateDocumentRgNumber,
    required bool allowToUpdateDocumentRgIssuanceDate,
    required bool allowToUpdateDocumentRgIssuingBody,
    required bool allowToUpdateDocumentRgIssuingState,
    required bool allowToUpdateDocumentVoterNumber,
    required bool allowToUpdateDocumentVoterZone,
    required bool allowToUpdateDocumentVoterSection,
    required bool allowToUpdateDocumentCtpsIssuedDate,
    required bool allowToUpdateDocumentCtpsState,
    required bool allowToUpdateDocumentCtpsDigit,
    required bool allowToUpdateDocumentCtpsSerie,
    required bool allowToUpdateDocumentCtpsNumber,
    required bool allowToUpdateDocumentCnhNumber,
    required bool allowToUpdateDocumentCnhCategory,
    required bool allowToUpdateDocumentCnhIssuingBody,
    required bool allowToUpdateDocumentCnhIssuingState,
    required bool allowToUpdateDocumentCnhIssuanceDate,
    required bool allowToUpdateDocumentCnhFirstIssuedDate,
    required bool allowToUpdateDocumentCnhExpiryDate,
    required bool allowToUpdateDocumentRicNumber,
    required bool allowToUpdateDocumentRicIssuanceDate,
    required bool allowToUpdateDocumentRicIssuingBody,
    required bool allowToUpdateDocumentRicIssuingCity,
    required bool allowToUpdateDocumentPassportNumber,
    required bool allowToUpdateDocumentPassportCountry,
    required bool allowToUpdateDocumentPassportIssuingBody,
    required bool allowToUpdateDocumentPassportState,
    required bool allowToUpdateDocumentPassportIssuanceDate,
    required bool allowToUpdateDocumentPassportExpiryDate,
    required bool allowToUpdateDocumentNisNumber,
    required bool allowToUpdateDocumentNisRegistrationDate,
    required bool allowToUpdateDocumentReservistNumber,
    required bool allowToUpdateDocumentReservistCategory,
    required bool allowToUpdateDocumentCnsNumber,
    required bool allowToUpdateDocumentCertificate,
    required bool allowToUpdateDocumentAttachment,
    required bool allowToUpdateDocumentNotes,
    required bool allowToUpdateDocumentVisaNumber,
    required bool allowToUpdateDocumentVisaIssuedDate,
    required bool allowToUpdateDocumentVisaExpiryDate,
    required bool allowToUpdateDocumentVisaType,
    required bool allowToUpdateDocumentRneNumber,
    required bool allowToUpdateDocumentRneIssuingBody,
    required bool allowToUpdateDocumentRneIssuedDate,
    required bool allowToUpdateEmergencyContactPhoneDDI,
    required bool allowToUpdateEmergencyContactPhoneDDD,
    required bool allowToUpdateEmergencyContactPhoneNumber,
    required bool allowToUpdateEmergencyContactPhoneExtension,
    required bool allowToUpdateEmergencyContactPhoneProvider,
    required bool allowToUpdateEmergencyContactPhoneKinship,
    required bool allowToUpdateEmergencyContactPhoneName,
    required bool allowToUpdateEmergencyContactPhoneGender,
    required bool allowToViewVacationSignature,
    required bool allowToViewHyperlinks,
    required SocialAuthorizationEntity socialAuthorizationEntity,
    required bool isWaapiLite,
    required bool allowToViewDiversity,
    required bool allowToViewWorkContract,
  })  : _allowToPayroll = allowToPayroll,
        _allowToViewMyFeedbacks = allowToViewMyFeedbacks,
        _allowToViewMyFeedbacksRequests = allowToViewMyFeedbacksRequests,
        _allowToWriteFeedback = allowToWriteFeedback,
        _allowToRequestFeedback = allowToRequestFeedback,
        _allowToToggleInternalFeedbackSharing = allowToToggleInternalFeedbackSharing,
        _allowToMakeFeedbackVisibleToEmployeeAndManager = allowToMakeFeedbackVisibleToEmployeeAndManager,
        _allowToMakeFeedbackVisibleToEvaluator = allowToMakeFeedbackVisibleToEvaluator,
        _allowToMakeFeedbackVisibleToManager = allowToMakeFeedbackVisibleToManager,
        _allowToMakeFeedbackVisibleToEmployee = allowToMakeFeedbackVisibleToEmployee,
        _allowToViewMyProfile = allowToViewMyProfile,
        _allowToViewVacations = allowToViewVacations,
        _allowToSearchPeople = allowToSearchPeople,
        _allowToViewBirthdayCorporateMural = allowToViewBirthdayCorporateMural,
        _allowToViewCompanyBirthdayCorporateMural = allowToViewCompanyBirthdayCorporateMural,
        _allowToViewVacationAnalytics = allowToViewVacationAnalytics,
        _allowEmployeeRequestVacation = allowEmployeeRequestVacation,
        _show13thSalaryAdvance = show13thSalaryAdvance,
        _showBonusDays = showBonusDays,
        _allowBonusDaysOnlyWhenThereIsBalance = allowBonusDaysOnlyWhenThereIsBalance,
        _allowCancellationScheduledVacation = allowCancellationScheduledVacation,
        _vacationHelpDescription = vacationHelpDescription,
        _allowToUpdatePersonalData = allowToUpdatePersonalData,
        _allowToUpdatePersonalContact = allowToUpdatePersonalContact,
        _allowToUpdateEmergencyContact = allowToUpdateEmergencyContact,
        _allowToUpdatePersonalDocuments = allowToUpdatePersonalDocuments,
        _allowToUpdatePersonalAddress = allowToUpdatePersonalAddress,
        _allowToViewCalendarVacations = allowToViewCalendarVacations,
        _allowToViewTimeManagement = allowToViewTimeManagement,
        _allowToViewClockingMobileLog = allowToViewClockingMobileLog,
        _allowToFinancialData = allowToFinancialData,
        _allowToUpdatePersonalDependents = allowToUpdatePersonalDependents,
        _allowToViewDependents = allowToViewDependents,
        _enableDependentIncomeTax = enableDependentIncomeTax,
        _enablePersonalPhoto = enablePersonalPhoto,
        _allowToUpdatePersonalDataName = allowToUpdatePersonalDataName,
        _allowToUpdatePersonalDataNationality = allowToUpdatePersonalDataNationality,
        _allowToUpdatePersonalDataDisability = allowToUpdatePersonalDataDisability,
        _allowToUpdatePersonalDataRace = allowToUpdatePersonalDataRace,
        _allowToUpdatePersonalDataBirthday = allowToUpdatePersonalDataBirthday,
        _allowToUpdatePersonalDataNotes = allowToUpdatePersonalDataNotes,
        _allowToUpdatePersonalDataBirthplace = allowToUpdatePersonalDataBirthplace,
        _allowToUpdatePersonalDataEducationLevel = allowToUpdatePersonalDataEducationLevel,
        _allowToUpdatePersonalDataMaritalStatus = allowToUpdatePersonalDataMaritalStatus,
        _allowToUpdatePersonalDataGender = allowToUpdatePersonalDataGender,
        _allowToUpdateContactProfessionalEmail = allowToUpdateContactProfessionalEmail,
        _allowToUpdateContactPersonalEmail = allowToUpdateContactPersonalEmail,
        _allowToUpdateContactPhoneType = allowToUpdateContactPhoneType,
        _allowToUpdateContactPhoneDDI = allowToUpdateContactPhoneDDI,
        _allowToUpdateContactPhoneDDD = allowToUpdateContactPhoneDDD,
        _allowToUpdateContactPhoneNumber = allowToUpdateContactPhoneNumber,
        _allowToUpdateContactPhoneExtension = allowToUpdateContactPhoneExtension,
        _allowToUpdateContactPhoneProvider = allowToUpdateContactPhoneProvider,
        _allowToUpdateContactPhoneAction = allowToUpdateContactPhoneAction,
        _allowToUpdateContactEmailType = allowToUpdateContactEmailType,
        _allowToUpdateContactEmailDescription = allowToUpdateContactEmailDescription,
        _allowToUpdateContactEmailAction = allowToUpdateContactEmailAction,
        _allowToUpdateContactSocialNetworkType = allowToUpdateContactSocialNetworkType,
        _allowToUpdateContactSocialNetworkUsername = allowToUpdateContactSocialNetworkUsername,
        _allowToUpdateContactSocialNetworkAction = allowToUpdateContactSocialNetworkAction,
        _allowToUpdateContactNotes = allowToUpdateContactNotes,
        _allowToUpdateAddressZipCode = allowToUpdateAddressZipCode,
        _allowToUpdateAddressPatioType = allowToUpdateAddressPatioType,
        _allowToUpdateAddressPatio = allowToUpdateAddressPatio,
        _allowToUpdateAddressNumber = allowToUpdateAddressNumber,
        _allowToUpdateAddressAdditional = allowToUpdateAddressAdditional,
        _allowToUpdateAddressNeighborhood = allowToUpdateAddressNeighborhood,
        _allowToUpdateAddressCity = allowToUpdateAddressCity,
        _allowToUpdateAddressAdmRegion = allowToUpdateAddressAdmRegion,
        _allowToUpdateAddressNotes = allowToUpdateAddressNotes,
        _allowToUpdateDocumentCpf = allowToUpdateDocumentCpf,
        _allowToUpdateDocumentRgNumber = allowToUpdateDocumentRgNumber,
        _allowToUpdateDocumentRgIssuanceDate = allowToUpdateDocumentRgIssuanceDate,
        _allowToUpdateDocumentRgIssuingBody = allowToUpdateDocumentRgIssuingBody,
        _allowToUpdateDocumentRgIssuingState = allowToUpdateDocumentRgIssuingState,
        _allowToUpdateDocumentVoterNumber = allowToUpdateDocumentVoterNumber,
        _allowToUpdateDocumentVoterZone = allowToUpdateDocumentVoterZone,
        _allowToUpdateDocumentVoterSection = allowToUpdateDocumentVoterSection,
        _allowToUpdateDocumentCtpsIssuedDate = allowToUpdateDocumentCtpsIssuedDate,
        _allowToUpdateDocumentCtpsState = allowToUpdateDocumentCtpsState,
        _allowToUpdateDocumentCtpsDigit = allowToUpdateDocumentCtpsDigit,
        _allowToUpdateDocumentCtpsSerie = allowToUpdateDocumentCtpsSerie,
        _allowToUpdateDocumentCtpsNumber = allowToUpdateDocumentCtpsNumber,
        _allowToUpdateDocumentCnhNumber = allowToUpdateDocumentCnhNumber,
        _allowToUpdateDocumentCnhCategory = allowToUpdateDocumentCnhCategory,
        _allowToUpdateDocumentCnhIssuingBody = allowToUpdateDocumentCnhIssuingBody,
        _allowToUpdateDocumentCnhIssuingState = allowToUpdateDocumentCnhIssuingState,
        _allowToUpdateDocumentCnhIssuanceDate = allowToUpdateDocumentCnhIssuanceDate,
        _allowToUpdateDocumentCnhFirstIssuedDate = allowToUpdateDocumentCnhFirstIssuedDate,
        _allowToUpdateDocumentCnhExpiryDate = allowToUpdateDocumentCnhExpiryDate,
        _allowToUpdateDocumentRicNumber = allowToUpdateDocumentRicNumber,
        _allowToUpdateDocumentRicIssuanceDate = allowToUpdateDocumentRicIssuanceDate,
        _allowToUpdateDocumentRicIssuingBody = allowToUpdateDocumentRicIssuingBody,
        _allowToUpdateDocumentRicIssuingCity = allowToUpdateDocumentRicIssuingCity,
        _allowToUpdateDocumentPassportNumber = allowToUpdateDocumentPassportNumber,
        _allowToUpdateDocumentPassportCountry = allowToUpdateDocumentPassportCountry,
        _allowToUpdateDocumentPassportIssuingBody = allowToUpdateDocumentPassportIssuingBody,
        _allowToUpdateDocumentPassportState = allowToUpdateDocumentPassportState,
        _allowToUpdateDocumentPassportIssuanceDate = allowToUpdateDocumentPassportIssuanceDate,
        _allowToUpdateDocumentPassportExpiryDate = allowToUpdateDocumentPassportExpiryDate,
        _allowToUpdateDocumentNisNumber = allowToUpdateDocumentNisNumber,
        _allowToUpdateDocumentNisRegistrationDate = allowToUpdateDocumentNisRegistrationDate,
        _allowToUpdateDocumentReservistNumber = allowToUpdateDocumentReservistNumber,
        _allowToUpdateDocumentReservistCategory = allowToUpdateDocumentReservistCategory,
        _allowToUpdateDocumentCnsNumber = allowToUpdateDocumentCnsNumber,
        _allowToUpdateDocumentCertificate = allowToUpdateDocumentCertificate,
        _allowToUpdateDocumentAttachment = allowToUpdateDocumentAttachment,
        _allowToUpdateDocumentNotes = allowToUpdateDocumentNotes,
        _allowToUpdateDocumentVisaNumber = allowToUpdateDocumentVisaNumber,
        _allowToUpdateDocumentVisaIssuedDate = allowToUpdateDocumentVisaIssuedDate,
        _allowToUpdateDocumentVisaExpiryDate = allowToUpdateDocumentVisaExpiryDate,
        _allowToUpdateDocumentVisaType = allowToUpdateDocumentVisaType,
        _allowToUpdateDocumentRneNumber = allowToUpdateDocumentRneNumber,
        _allowToUpdateDocumentRneIssuingBody = allowToUpdateDocumentRneIssuingBody,
        _allowToUpdateDocumentRneIssuedDate = allowToUpdateDocumentRneIssuedDate,
        _allowToUpdateEmergencyContactPhoneDDI = allowToUpdateEmergencyContactPhoneDDI,
        _allowToUpdateEmergencyContactPhoneDDD = allowToUpdateEmergencyContactPhoneDDD,
        _allowToUpdateEmergencyContactPhoneNumber = allowToUpdateEmergencyContactPhoneNumber,
        _allowToUpdateEmergencyContactPhoneExtension = allowToUpdateEmergencyContactPhoneExtension,
        _allowToUpdateEmergencyContactPhoneProvider = allowToUpdateEmergencyContactPhoneProvider,
        _allowToUpdateEmergencyContactPhoneKinship = allowToUpdateEmergencyContactPhoneKinship,
        _allowToUpdateEmergencyContactPhoneName = allowToUpdateEmergencyContactPhoneName,
        _allowToUpdateEmergencyContactPhoneGender = allowToUpdateEmergencyContactPhoneGender,
        _allowToViewVacationSignature = allowToViewVacationSignature,
        _allowToViewHyperlinks = allowToViewHyperlinks,
        _socialAuthorizationEntity = socialAuthorizationEntity,
        _isWaapiLite = isWaapiLite,
        _allowToViewDiversity = allowToViewDiversity,
        _allowToViewWorkContract = allowToViewWorkContract;

  bool get allowToViewDiversity {
    return _allowToViewDiversity;
  }

  bool get allowToUpdatePersonalDataName {
    return _allowToUpdatePersonalDataName;
  }

  bool get allowToUpdatePersonalDataNationality {
    return _allowToUpdatePersonalDataNationality;
  }

  bool get allowToUpdatePersonalDataDisability {
    return _allowToUpdatePersonalDataDisability;
  }

  bool get allowToUpdatePersonalDataRace {
    return _allowToUpdatePersonalDataRace;
  }

  bool get allowToUpdatePersonalDataBirthday {
    return _allowToUpdatePersonalDataBirthday;
  }

  bool get allowToUpdatePersonalDataNotes {
    return _allowToUpdatePersonalDataNotes;
  }

  bool get allowToUpdatePersonalDataBirthplace {
    return _allowToUpdatePersonalDataBirthplace;
  }

  bool get allowToUpdatePersonalDataEducationLevel {
    return _allowToUpdatePersonalDataEducationLevel;
  }

  bool get allowToUpdatePersonalDataMaritalStatus {
    return _allowToUpdatePersonalDataMaritalStatus;
  }

  bool get allowToUpdatePersonalDataGender {
    return _allowToUpdatePersonalDataGender;
  }

  bool get allowToUpdatePersonalData {
    return _allowToUpdatePersonalData;
  }

  bool get allowToUpdatePersonalContact {
    return _allowToUpdatePersonalContact;
  }

  bool get allowToViewMyFeedbacks {
    return _allowToViewMyFeedbacks;
  }

  bool get allowToViewMyFeedbacksRequests {
    return _allowToViewMyFeedbacksRequests;
  }

  bool get allowToWriteFeedback {
    return _allowToWriteFeedback;
  }

  bool get allowToRequestFeedback {
    return _allowToRequestFeedback;
  }

  bool get allowToViewFeedbacksOrRequests {
    return _allowToViewMyFeedbacks || _allowToViewMyFeedbacksRequests;
  }

  bool get allowToToggleInternalFeedbackSharing {
    return _allowToToggleInternalFeedbackSharing;
  }

  bool get allowToMakeFeedbackVisibleToEmployeeAndManager {
    return _allowToMakeFeedbackVisibleToEmployeeAndManager;
  }

  bool get allowToMakeFeedbackVisibleToEvaluator {
    return _allowToMakeFeedbackVisibleToEvaluator;
  }

  bool get allowToMakeFeedbackVisibleToManager {
    return _allowToMakeFeedbackVisibleToManager;
  }

  bool get allowToMakeFeedbackVisibleToEmployee {
    return _allowToMakeFeedbackVisibleToEmployee;
  }

  bool get allowToViewMyProfile {
    return _allowToViewMyProfile;
  }

  bool get allowToViewVacations {
    return _allowToViewVacations;
  }

  bool get allowToSearchPeople {
    return _allowToSearchPeople;
  }

  bool get allowToViewBirthdayCorporateMural {
    return _allowToViewBirthdayCorporateMural;
  }

  bool get allowToViewCompanyBirthdayCorporateMural {
    return _allowToViewCompanyBirthdayCorporateMural;
  }

  bool get allowToViewVacationAnalytics {
    return _allowToViewVacationAnalytics;
  }

  bool get allowEmployeeRequestVacation {
    return _allowEmployeeRequestVacation;
  }

  bool get show13thSalaryAdvance {
    return _show13thSalaryAdvance;
  }

  bool get showBonusDays {
    return _showBonusDays;
  }

  bool get allowBonusDaysOnlyWhenThereIsBalance {
    return _allowBonusDaysOnlyWhenThereIsBalance;
  }

  String? get vacationHelpDescription {
    return _vacationHelpDescription;
  }

  bool get allowCancellationScheduledVacation {
    return _allowCancellationScheduledVacation;
  }

  bool get allowToUpdateEmergencyContact {
    return _allowToUpdateEmergencyContact;
  }

  bool get allowToUpdatePersonalAddress {
    return _allowToUpdatePersonalAddress;
  }

  bool get allowToUpdateContactProfessionalEmail {
    return _allowToUpdateContactProfessionalEmail;
  }

  bool get allowToUpdateContactEmailAction {
    return _allowToUpdateContactEmailAction;
  }

  bool get allowToUpdateContactEmailDescription {
    return _allowToUpdateContactEmailDescription;
  }

  bool get allowToUpdateContactEmailType {
    return _allowToUpdateContactEmailType;
  }

  bool get allowToUpdateContactNotes {
    return _allowToUpdateContactNotes;
  }

  bool get allowToUpdateContactPersonalEmail {
    return _allowToUpdateContactPersonalEmail;
  }

  bool get allowToUpdateContactPhoneAction {
    return _allowToUpdateContactPhoneAction;
  }

  bool get allowToUpdateContactPhoneDDD {
    return _allowToUpdateContactPhoneDDD;
  }

  bool get allowToUpdateContactPhoneDDI {
    return _allowToUpdateContactPhoneDDI;
  }

  bool get allowToUpdateContactPhoneExtension {
    return _allowToUpdateContactPhoneExtension;
  }

  bool get allowToUpdateContactPhoneNumber {
    return _allowToUpdateContactPhoneNumber;
  }

  bool get allowToUpdateContactPhoneProvider {
    return _allowToUpdateContactPhoneProvider;
  }

  bool get allowToUpdateContactPhoneType {
    return _allowToUpdateContactPhoneType;
  }

  bool get allowToUpdateContactSocialNetworkAction {
    return _allowToUpdateContactSocialNetworkAction;
  }

  bool get allowToUpdateContactSocialNetworkType {
    return _allowToUpdateContactSocialNetworkType;
  }

  bool get allowToUpdateContactSocialNetworkUsername {
    return _allowToUpdateContactSocialNetworkUsername;
  }

  bool get allowToUpdatePersonalDocuments {
    return _allowToUpdatePersonalDocuments;
  }

  bool get allowToViewCalendarVacations {
    return _allowToViewCalendarVacations;
  }

  bool get allowToViewTimeManagement {
    return _allowToViewTimeManagement;
  }

  bool get allowToViewClockingMobileLog {
    return _allowToViewClockingMobileLog;
  }

  bool get allowToFinancialData {
    return _allowToFinancialData;
  }

  bool get allowToUpdatePersonalDependents {
    return _allowToUpdatePersonalDependents;
  }

  bool get allowToViewDependents {
    return _allowToViewDependents;
  }

  bool get enableDependentIncomeTax {
    return _enableDependentIncomeTax;
  }

  bool get allowToPayroll {
    return _allowToPayroll;
  }

  bool get enablePersonalPhoto {
    return _enablePersonalPhoto;
  }

  bool get allowToUpdateAddressZipCode {
    return _allowToUpdateAddressZipCode;
  }

  bool get allowToUpdateAddressPatioType {
    return _allowToUpdateAddressPatioType;
  }

  bool get allowToUpdateAddressPatio {
    return _allowToUpdateAddressPatio;
  }

  bool get allowToUpdateAddressNumber {
    return _allowToUpdateAddressNumber;
  }

  bool get allowToUpdateAddressAdditional {
    return _allowToUpdateAddressAdditional;
  }

  bool get allowToUpdateAddressNeighborhood {
    return _allowToUpdateAddressNeighborhood;
  }

  bool get allowToUpdateAddressCity {
    return _allowToUpdateAddressCity;
  }

  bool get allowToUpdateAddressAdmRegion {
    return _allowToUpdateAddressAdmRegion;
  }

  bool get allowToUpdateAddressNotes {
    return _allowToUpdateAddressNotes;
  }

  bool get allowToUpdateDocumentCpf {
    return _allowToUpdateDocumentCpf;
  }

  bool get allowToUpdateDocumentRgNumber {
    return _allowToUpdateDocumentRgNumber;
  }

  bool get allowToUpdateDocumentRgIssuanceDate {
    return _allowToUpdateDocumentRgIssuanceDate;
  }

  bool get allowToUpdateDocumentRgIssuingBody {
    return _allowToUpdateDocumentRgIssuingBody;
  }

  bool get allowToUpdateDocumentRgIssuingState {
    return _allowToUpdateDocumentRgIssuingState;
  }

  bool get allowToUpdateDocumentVoterNumber {
    return _allowToUpdateDocumentVoterNumber;
  }

  bool get allowToUpdateDocumentVoterZone {
    return _allowToUpdateDocumentVoterZone;
  }

  bool get allowToUpdateDocumentVoterSection {
    return _allowToUpdateDocumentVoterSection;
  }

  bool get allowToUpdateDocumentCtpsIssuedDate {
    return _allowToUpdateDocumentCtpsIssuedDate;
  }

  bool get allowToUpdateDocumentCtpsState {
    return _allowToUpdateDocumentCtpsState;
  }

  bool get allowToUpdateDocumentCtpsDigit {
    return _allowToUpdateDocumentCtpsDigit;
  }

  bool get allowToUpdateDocumentCtpsSerie {
    return _allowToUpdateDocumentCtpsSerie;
  }

  bool get allowToUpdateDocumentCtpsNumber {
    return _allowToUpdateDocumentCtpsNumber;
  }

  bool get allowToUpdateDocumentCnhNumber {
    return _allowToUpdateDocumentCnhNumber;
  }

  bool get allowToUpdateDocumentCnhCategory {
    return _allowToUpdateDocumentCnhCategory;
  }

  bool get allowToUpdateDocumentCnhIssuingBody {
    return _allowToUpdateDocumentCnhIssuingBody;
  }

  bool get allowToUpdateDocumentCnhIssuingState {
    return _allowToUpdateDocumentCnhIssuingState;
  }

  bool get allowToUpdateDocumentCnhIssuanceDate {
    return _allowToUpdateDocumentCnhIssuanceDate;
  }

  bool get allowToUpdateDocumentCnhFirstIssuedDate {
    return _allowToUpdateDocumentCnhFirstIssuedDate;
  }

  bool get allowToUpdateDocumentCnhExpiryDate {
    return _allowToUpdateDocumentCnhExpiryDate;
  }

  bool get allowToUpdateDocumentRicNumber {
    return _allowToUpdateDocumentRicNumber;
  }

  bool get allowToUpdateDocumentRicIssuanceDate {
    return _allowToUpdateDocumentRicIssuanceDate;
  }

  bool get allowToUpdateDocumentRicIssuingBody {
    return _allowToUpdateDocumentRicIssuingBody;
  }

  bool get allowToUpdateDocumentRicIssuingCity {
    return _allowToUpdateDocumentRicIssuingCity;
  }

  bool get allowToUpdateDocumentPassportNumber {
    return _allowToUpdateDocumentPassportNumber;
  }

  bool get allowToUpdateDocumentPassportCountry {
    return _allowToUpdateDocumentPassportCountry;
  }

  bool get allowToUpdateDocumentPassportIssuingBody {
    return _allowToUpdateDocumentPassportIssuingBody;
  }

  bool get allowToUpdateDocumentPassportState {
    return _allowToUpdateDocumentPassportState;
  }

  bool get allowToUpdateDocumentPassportIssuanceDate {
    return _allowToUpdateDocumentPassportIssuanceDate;
  }

  bool get allowToUpdateDocumentPassportExpiryDate {
    return _allowToUpdateDocumentPassportExpiryDate;
  }

  bool get allowToUpdateDocumentNisNumber {
    return _allowToUpdateDocumentNisNumber;
  }

  bool get allowToUpdateDocumentNisRegistrationDate {
    return _allowToUpdateDocumentNisRegistrationDate;
  }

  bool get allowToUpdateDocumentReservistNumber {
    return _allowToUpdateDocumentReservistNumber;
  }

  bool get allowToUpdateDocumentReservistCategory {
    return _allowToUpdateDocumentReservistCategory;
  }

  bool get allowToUpdateDocumentCnsNumber {
    return _allowToUpdateDocumentCnsNumber;
  }

  bool get allowToUpdateDocumentCertificate {
    return _allowToUpdateDocumentCertificate;
  }

  bool get allowToUpdateDocumentAttachment {
    return _allowToUpdateDocumentAttachment;
  }

  bool get allowToUpdateDocumentNotes {
    return _allowToUpdateDocumentNotes;
  }

  bool get allowToUpdateDocumentVisaNumber {
    return _allowToUpdateDocumentVisaNumber;
  }

  bool get allowToUpdateDocumentVisaIssuedDate {
    return _allowToUpdateDocumentVisaIssuedDate;
  }

  bool get allowToUpdateDocumentVisaExpiryDate {
    return _allowToUpdateDocumentVisaExpiryDate;
  }

  bool get allowToUpdateDocumentVisaType {
    return _allowToUpdateDocumentVisaType;
  }

  bool get allowToUpdateDocumentRneNumber {
    return _allowToUpdateDocumentRneNumber;
  }

  bool get allowToUpdateDocumentRneIssuingBody {
    return _allowToUpdateDocumentRneIssuingBody;
  }

  bool get allowToUpdateDocumentRneIssuedDate {
    return _allowToUpdateDocumentRneIssuedDate;
  }

  bool get allowToUpdateEmergencyContactPhoneDDI {
    return _allowToUpdateEmergencyContactPhoneDDI;
  }

  bool get allowToUpdateEmergencyContactPhoneDDD {
    return _allowToUpdateEmergencyContactPhoneDDD;
  }

  bool get allowToUpdateEmergencyContactPhoneNumber {
    return _allowToUpdateEmergencyContactPhoneNumber;
  }

  bool get allowToUpdateEmergencyContactPhoneExtension {
    return _allowToUpdateEmergencyContactPhoneExtension;
  }

  bool get allowToUpdateEmergencyContactPhoneProvider {
    return _allowToUpdateEmergencyContactPhoneProvider;
  }

  bool get allowToUpdateEmergencyContactPhoneKinship {
    return _allowToUpdateEmergencyContactPhoneKinship;
  }

  bool get allowToUpdateEmergencyContactPhoneName {
    return _allowToUpdateEmergencyContactPhoneName;
  }

  bool get allowToUpdateEmergencyContactPhoneGender {
    return _allowToUpdateEmergencyContactPhoneGender;
  }

  bool get allowToViewVacationSignature {
    return _allowToViewVacationSignature;
  }

  bool get allowToViewHyperlinks {
    return _allowToViewHyperlinks;
  }

  SocialAuthorizationEntity get socialAuthorizationEntity {
    return _socialAuthorizationEntity;
  }

  bool get isWaapiLite {
    return _isWaapiLite;
  }

  bool get allowToViewWorkContract {
    return _allowToViewWorkContract;
  }

  @override
  List<Object?> get props {
    return [
      _allowToViewMyFeedbacks,
      _allowToViewMyFeedbacksRequests,
      _allowToWriteFeedback,
      _allowToRequestFeedback,
      _allowToToggleInternalFeedbackSharing,
      _allowToMakeFeedbackVisibleToEmployeeAndManager,
      _allowToMakeFeedbackVisibleToEvaluator,
      _allowToMakeFeedbackVisibleToManager,
      _allowToMakeFeedbackVisibleToEmployee,
      _allowToViewMyProfile,
      _allowToViewVacations,
      _allowToSearchPeople,
      _allowToViewBirthdayCorporateMural,
      _allowToViewCompanyBirthdayCorporateMural,
      _allowToViewVacationAnalytics,
      _allowEmployeeRequestVacation,
      _show13thSalaryAdvance,
      _showBonusDays,
      _allowBonusDaysOnlyWhenThereIsBalance,
      _vacationHelpDescription,
      _allowCancellationScheduledVacation,
      _allowToUpdatePersonalData,
      _allowToUpdatePersonalAddress,
      _allowToUpdatePersonalContact,
      _allowToUpdateContactProfessionalEmail,
      _allowToUpdateEmergencyContact,
      _allowToUpdatePersonalDocuments,
      _allowToViewCalendarVacations,
      _allowToViewTimeManagement,
      _allowToViewClockingMobileLog,
      _allowToFinancialData,
      _allowToUpdatePersonalDependents,
      _allowToViewDependents,
      _enableDependentIncomeTax,
      _allowToPayroll,
      _enablePersonalPhoto,
      _allowToUpdatePersonalDataName,
      _allowToUpdatePersonalDataNationality,
      _allowToUpdatePersonalDataDisability,
      _allowToUpdatePersonalDataRace,
      _allowToUpdatePersonalDataBirthday,
      _allowToUpdatePersonalDataNotes,
      _allowToUpdatePersonalDataBirthplace,
      _allowToUpdatePersonalDataEducationLevel,
      _allowToUpdatePersonalDataMaritalStatus,
      _allowToUpdatePersonalDataGender,
      _allowToUpdateContactPersonalEmail,
      _allowToUpdateContactPhoneType,
      _allowToUpdateContactPhoneDDI,
      _allowToUpdateContactPhoneDDD,
      _allowToUpdateContactPhoneNumber,
      _allowToUpdateContactPhoneExtension,
      _allowToUpdateContactPhoneProvider,
      _allowToUpdateContactPhoneAction,
      _allowToUpdateContactEmailType,
      _allowToUpdateContactEmailDescription,
      _allowToUpdateContactEmailAction,
      _allowToUpdateContactSocialNetworkType,
      _allowToUpdateContactSocialNetworkUsername,
      _allowToUpdateContactSocialNetworkAction,
      _allowToUpdateContactNotes,
      _allowToUpdateAddressZipCode,
      _allowToUpdateAddressPatioType,
      _allowToUpdateAddressPatio,
      _allowToUpdateAddressNumber,
      _allowToUpdateAddressAdditional,
      _allowToUpdateAddressNeighborhood,
      _allowToUpdateAddressCity,
      _allowToUpdateAddressAdmRegion,
      _allowToUpdateAddressNotes,
      _allowToUpdateDocumentCpf,
      _allowToUpdateDocumentRgNumber,
      _allowToUpdateDocumentRgIssuanceDate,
      _allowToUpdateDocumentRgIssuingBody,
      _allowToUpdateDocumentRgIssuingState,
      _allowToUpdateDocumentVoterNumber,
      _allowToUpdateDocumentVoterZone,
      _allowToUpdateDocumentVoterSection,
      _allowToUpdateDocumentCtpsIssuedDate,
      _allowToUpdateDocumentCtpsState,
      _allowToUpdateDocumentCtpsDigit,
      _allowToUpdateDocumentCtpsSerie,
      _allowToUpdateDocumentCtpsNumber,
      _allowToUpdateDocumentCnhNumber,
      _allowToUpdateDocumentCnhCategory,
      _allowToUpdateDocumentCnhIssuingBody,
      _allowToUpdateDocumentCnhIssuingState,
      _allowToUpdateDocumentCnhIssuanceDate,
      _allowToUpdateDocumentCnhFirstIssuedDate,
      _allowToUpdateDocumentCnhExpiryDate,
      _allowToUpdateDocumentRicNumber,
      _allowToUpdateDocumentRicIssuanceDate,
      _allowToUpdateDocumentRicIssuingBody,
      _allowToUpdateDocumentRicIssuingCity,
      _allowToUpdateDocumentPassportNumber,
      _allowToUpdateDocumentPassportCountry,
      _allowToUpdateDocumentPassportIssuingBody,
      _allowToUpdateDocumentPassportState,
      _allowToUpdateDocumentPassportIssuanceDate,
      _allowToUpdateDocumentPassportExpiryDate,
      _allowToUpdateDocumentNisNumber,
      _allowToUpdateDocumentNisRegistrationDate,
      _allowToUpdateDocumentReservistNumber,
      _allowToUpdateDocumentReservistCategory,
      _allowToUpdateDocumentCnsNumber,
      _allowToUpdateDocumentCertificate,
      _allowToUpdateDocumentAttachment,
      _allowToUpdateDocumentNotes,
      _allowToUpdateDocumentVisaNumber,
      _allowToUpdateDocumentVisaIssuedDate,
      _allowToUpdateDocumentVisaExpiryDate,
      _allowToUpdateDocumentVisaType,
      _allowToUpdateDocumentRneNumber,
      _allowToUpdateDocumentRneIssuingBody,
      _allowToUpdateDocumentRneIssuedDate,
      _allowToUpdateEmergencyContactPhoneDDI,
      _allowToUpdateEmergencyContactPhoneDDD,
      _allowToUpdateEmergencyContactPhoneNumber,
      _allowToUpdateEmergencyContactPhoneExtension,
      _allowToUpdateEmergencyContactPhoneProvider,
      _allowToUpdateEmergencyContactPhoneKinship,
      _allowToUpdateEmergencyContactPhoneName,
      _allowToUpdateEmergencyContactPhoneGender,
      _allowToViewVacationSignature,
      _allowToViewHyperlinks,
      _socialAuthorizationEntity,
      _isWaapiLite,
      _allowToViewDiversity,
      _allowToViewWorkContract,
    ];
  }
}
