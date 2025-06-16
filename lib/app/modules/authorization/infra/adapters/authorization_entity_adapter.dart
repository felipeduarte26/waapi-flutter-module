import '../../domain/entities/authorization_entity.dart';
import '../../domain/entities/social_authorization_entity.dart';
import '../../helper/authorization_helper.dart';
import '../models/feature_control_authorization_model.dart';
import '../models/legacy_authorization_model.dart';
import '../models/platform_authorizations_aggregator_model.dart';
import 'social_authorization_entity_adapter.dart';

class AuthorizationEntityAdapter {
  AuthorizationEntity fromLegacyAndPlatform({
    required LegacyAuthorizationModel legacyAuthorizationModel,
    required PlatformAuthorizationsAggregatorModel platformAuthorizationsAggregatorModel,
    required FeatureControlAuthorizationModel featureControlAuthorizationModel,
    required bool isWaapiLite,
  }) {
    bool platformMyFeedbacks = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/hcm/performance_management/feedback/myFeedbacks',
      action: 'Visualizar',
    );

    bool platformMyFeedbacksRequest = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/hcm/performance_management/feedback/myFeedbackRequests',
      action: 'Visualizar',
    );

    bool platformRequestFeedbacks = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/hcm/performance_management/feedback/requestFeedbacks',
      action: 'Visualizar',
    );

    bool platformWriteFeedbacks = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/hcm/performance_management/feedback/newFeedbacks',
      action: 'Visualizar',
    );

    bool platformMyProfile = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/hcm/management_panel/profile/myProfile',
      action: 'Visualizar',
    );

    bool platformVacations = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/hcm/management_panel/vacation/myVacation',
      action: 'Visualizar',
    );

    bool platformSearchPeople = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/analytics/hcm/myAnalytics',
      action: 'Visualizar',
    );

    bool platformViewBirthdayCorporateMural = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/analytics/hcm/career/employee/birthdayCorporateMural',
      action: 'Visualizar',
    );

    bool platformViewCompanyBirthdayCorporateMural = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/analytics/hcm/career/employee/companyBirthdayCorporateMural',
      action: 'Visualizar',
    );

    bool platformViewVacationAnalytics = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/analytics/hcm/my/payroll/employee/vacation',
      action: 'Visualizar',
    );

    bool platformViewCalendarVacation = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/hcm/management_panel/vacation/employee/calendar',
      action: 'Visualizar',
    );

    bool platformViewTimeManagement = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/hcm/pontomobile/employee',
      action: 'Permitir',
    );

    bool platformViewClockingMobileLog = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/hcm/pontomobile/entities/mobileLog',
      action: 'Incluir',
    );

    bool platformViewFinancialData = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/hcm/management_panel/workContract/myPaymentStatement',
      action: 'Visualizar',
    );

    bool platformViewDependents = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/hcm/management_panel/workContract/myFamilyForm',
      action: 'Visualizar',
    );

    bool platformUseVacationSignature = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/hcm/vacationmanagement/useVacationSignature',
      action: 'Visualizar',
    );

    bool platformGedFile = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/platform/ecm_ged/file',
      action: 'Visualizar',
    );

    bool platformViewHyperlinks = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/analytics/hcm/resume/hyperlinks',
      action: 'Visualizar',
    );

    bool platformDiversityPersonView = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/hcm/diversity/entities/person',
      action: 'Visualizar',
    );

    bool platformDiversityPersonEdit = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/hcm/diversity/entities/person',
      action: 'Editar',
    );

    bool platformDiversityPersonAdd = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/hcm/diversity/entities/person',
      action: 'Incluir',
    );

    bool platformDiversityView = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/hcm/diversity/entities/diversity',
      action: 'Visualizar',
    );

    bool platformDiversityEdit = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/hcm/diversity/entities/diversity',
      action: 'Editar',
    );

    bool platformDiversityAdd = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/hcm/diversity/entities/diversity',
      action: 'Incluir',
    );

    bool platformWorkContractView = AuthorizationHelper.hasPermissionPlatformAuthorization(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
      resource: 'res://senior.com.br/hcm/management_panel/workContract/myWorkContract',
      action: 'Visualizar',
    );

    SocialAuthorizationEntity socialAuthorizationEntityAdapter =
        SocialAuthorizationEntityAdapter().fromLegacyAndPlatform(
      platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
    );

    return AuthorizationEntity(
      allowToViewDiversity: platformDiversityAdd &&
          platformDiversityEdit &&
          platformDiversityView &&
          platformDiversityPersonAdd &&
          platformDiversityPersonEdit &&
          platformDiversityPersonView &&
          featureControlAuthorizationModel.allowToMaintainSelfDeclaration,
      isWaapiLite: isWaapiLite,
      allowToViewVacationSignature: platformUseVacationSignature && platformGedFile,
      allowToViewMyFeedbacks: platformMyFeedbacks && !isWaapiLite,
      allowToViewMyFeedbacksRequests: platformMyFeedbacksRequest && !isWaapiLite,
      allowToRequestFeedback:
          platformRequestFeedbacks && legacyAuthorizationModel.allowToRequestFeedback && !isWaapiLite,
      allowToWriteFeedback: platformWriteFeedbacks && legacyAuthorizationModel.allowToWriteFeedback && !isWaapiLite,
      allowToViewMyProfile: platformMyProfile,
      allowToViewVacations: platformVacations && !isWaapiLite,
      allowToSearchPeople: platformSearchPeople,
      allowToViewCalendarVacations: platformViewCalendarVacation && !isWaapiLite,
      allowToViewTimeManagement: platformViewTimeManagement,
      allowToViewClockingMobileLog: platformViewClockingMobileLog,
      allowToFinancialData: platformViewFinancialData,
      allowToViewDependents: platformViewDependents,
      allowToViewBirthdayCorporateMural: platformViewBirthdayCorporateMural,
      allowToViewCompanyBirthdayCorporateMural: platformViewCompanyBirthdayCorporateMural,
      allowToViewVacationAnalytics: platformViewVacationAnalytics && !isWaapiLite,
      allowToViewHyperlinks: platformViewHyperlinks && !isWaapiLite,
      socialAuthorizationEntity: socialAuthorizationEntityAdapter,
      allowToUpdatePersonalData: featureControlAuthorizationModel.allowUpdatePersonalData,
      allowToUpdatePersonalContact: featureControlAuthorizationModel.allowUpdatePersonalContact,
      allowToUpdateEmergencyContact: featureControlAuthorizationModel.allowUpdateEmergencyContact,
      allowToUpdatePersonalDocuments: featureControlAuthorizationModel.allowUpdatePersonalDocuments,
      allowToUpdatePersonalAddress: featureControlAuthorizationModel.allowUpdatePersonalAddress,
      allowToUpdatePersonalDependents: featureControlAuthorizationModel.allowUpdatePersonalDependents && !isWaapiLite,
      enableDependentIncomeTax: featureControlAuthorizationModel.enableDependentIncomeTax,
      allowToPayroll: featureControlAuthorizationModel.allowToPayroll && !isWaapiLite,
      enablePersonalPhoto: featureControlAuthorizationModel.enablePersonalPhoto,
      allowToMakeFeedbackVisibleToManager: legacyAuthorizationModel.feedbackLeader,
      allowToMakeFeedbackVisibleToEmployeeAndManager: legacyAuthorizationModel.feedbackEmployee,
      allowToMakeFeedbackVisibleToEmployee: legacyAuthorizationModel.feedbackOnlyEmployee,
      allowToMakeFeedbackVisibleToEvaluator: legacyAuthorizationModel.feedbackEvaluator,
      allowToToggleInternalFeedbackSharing: legacyAuthorizationModel.shareFeedbacks,
      allowEmployeeRequestVacation: legacyAuthorizationModel.allowEmployeeRequestVacation && !isWaapiLite,
      show13thSalaryAdvance: legacyAuthorizationModel.show13thSalaryAdvance,
      showBonusDays: legacyAuthorizationModel.showBonusDays,
      allowBonusDaysOnlyWhenThereIsBalance: legacyAuthorizationModel.allowBonusDaysOnlyWhenThereIsBalance,
      allowCancellationScheduledVacation: legacyAuthorizationModel.allowCancellationScheduledVacation,
      allowToUpdateContactProfessionalEmail: legacyAuthorizationModel.allowToUpdateContactProfessionalEmail,
      vacationHelpDescription: legacyAuthorizationModel.vacationHelpDescription,
      allowToUpdatePersonalDataName: legacyAuthorizationModel.allowToUpdatePersonalDataName,
      allowToUpdatePersonalDataNationality: legacyAuthorizationModel.allowToUpdatePersonalDataNationality,
      allowToUpdatePersonalDataDisability: legacyAuthorizationModel.allowToUpdatePersonalDataDisability,
      allowToUpdatePersonalDataRace: legacyAuthorizationModel.allowToUpdatePersonalDataRace,
      allowToUpdatePersonalDataBirthday: legacyAuthorizationModel.allowToUpdatePersonalDataBirthday,
      allowToUpdatePersonalDataNotes: legacyAuthorizationModel.allowToUpdatePersonalDataNotes,
      allowToUpdatePersonalDataBirthplace: legacyAuthorizationModel.allowToUpdatePersonalDataBirthplace,
      allowToUpdatePersonalDataEducationLevel: legacyAuthorizationModel.allowToUpdatePersonalDataEducationLevel,
      allowToUpdatePersonalDataMaritalStatus: legacyAuthorizationModel.allowToUpdatePersonalDataMaritalStatus,
      allowToUpdatePersonalDataGender: legacyAuthorizationModel.allowToUpdatePersonalDataGender,
      allowToUpdateContactEmailAction: legacyAuthorizationModel.allowToUpdateContactEmailAction,
      allowToUpdateContactEmailDescription: legacyAuthorizationModel.allowToUpdateContactEmailDescription,
      allowToUpdateContactEmailType: legacyAuthorizationModel.allowToUpdateContactEmailType,
      allowToUpdateContactNotes: legacyAuthorizationModel.allowToUpdateContactNotes,
      allowToUpdateContactPersonalEmail: legacyAuthorizationModel.allowToUpdateContactPersonalEmail,
      allowToUpdateContactPhoneAction: legacyAuthorizationModel.allowToUpdateContactPhoneAction,
      allowToUpdateContactPhoneDDD: legacyAuthorizationModel.allowToUpdateContactPhoneDDD,
      allowToUpdateContactPhoneDDI: legacyAuthorizationModel.allowToUpdateContactPhoneDDI,
      allowToUpdateContactPhoneExtension: legacyAuthorizationModel.allowToUpdateContactPhoneExtension,
      allowToUpdateContactPhoneNumber: legacyAuthorizationModel.allowToUpdateContactPhoneNumber,
      allowToUpdateContactPhoneProvider: legacyAuthorizationModel.allowToUpdateContactPhoneProvider,
      allowToUpdateContactPhoneType: legacyAuthorizationModel.allowToUpdateContactPhoneType,
      allowToUpdateContactSocialNetworkAction: legacyAuthorizationModel.allowToUpdateContactSocialNetworkAction,
      allowToUpdateContactSocialNetworkType: legacyAuthorizationModel.allowToUpdateContactSocialNetworkType,
      allowToUpdateContactSocialNetworkUsername: legacyAuthorizationModel.allowToUpdateContactSocialNetworkUsername,
      allowToUpdateDocumentCpf: legacyAuthorizationModel.allowToUpdateDocumentCpf,
      allowToUpdateDocumentRgNumber: legacyAuthorizationModel.allowToUpdateDocumentRgNumber,
      allowToUpdateDocumentRgIssuanceDate: legacyAuthorizationModel.allowToUpdateDocumentRgIssuanceDate,
      allowToUpdateDocumentRgIssuingBody: legacyAuthorizationModel.allowToUpdateDocumentRgIssuingBody,
      allowToUpdateDocumentRgIssuingState: legacyAuthorizationModel.allowToUpdateDocumentRgIssuingState,
      allowToUpdateDocumentVoterNumber: legacyAuthorizationModel.allowToUpdateDocumentVoterNumber,
      allowToUpdateDocumentVoterZone: legacyAuthorizationModel.allowToUpdateDocumentVoterZone,
      allowToUpdateDocumentVoterSection: legacyAuthorizationModel.allowToUpdateDocumentVoterSection,
      allowToUpdateDocumentCtpsIssuedDate: legacyAuthorizationModel.allowToUpdateDocumentCtpsIssuedDate,
      allowToUpdateDocumentCtpsState: legacyAuthorizationModel.allowToUpdateDocumentCtpsState,
      allowToUpdateDocumentCtpsDigit: legacyAuthorizationModel.allowToUpdateDocumentCtpsDigit,
      allowToUpdateDocumentCtpsSerie: legacyAuthorizationModel.allowToUpdateDocumentCtpsSerie,
      allowToUpdateDocumentCtpsNumber: legacyAuthorizationModel.allowToUpdateDocumentCtpsNumber,
      allowToUpdateDocumentCnhNumber: legacyAuthorizationModel.allowToUpdateDocumentCnhNumber,
      allowToUpdateDocumentCnhCategory: legacyAuthorizationModel.allowToUpdateDocumentCnhCategory,
      allowToUpdateDocumentCnhIssuingBody: legacyAuthorizationModel.allowToUpdateDocumentCnhIssuingBody,
      allowToUpdateDocumentCnhIssuingState: legacyAuthorizationModel.allowToUpdateDocumentCnhIssuingState,
      allowToUpdateDocumentCnhIssuanceDate: legacyAuthorizationModel.allowToUpdateDocumentCnhIssuanceDate,
      allowToUpdateDocumentCnhFirstIssuedDate: legacyAuthorizationModel.allowToUpdateDocumentCnhFirstIssuedDate,
      allowToUpdateDocumentCnhExpiryDate: legacyAuthorizationModel.allowToUpdateDocumentCnhExpiryDate,
      allowToUpdateDocumentRicNumber: legacyAuthorizationModel.allowToUpdateDocumentRicNumber,
      allowToUpdateDocumentRicIssuanceDate: legacyAuthorizationModel.allowToUpdateDocumentRicIssuanceDate,
      allowToUpdateDocumentRicIssuingBody: legacyAuthorizationModel.allowToUpdateDocumentRicIssuingBody,
      allowToUpdateDocumentRicIssuingCity: legacyAuthorizationModel.allowToUpdateDocumentRicIssuingCity,
      allowToUpdateDocumentPassportNumber: legacyAuthorizationModel.allowToUpdateDocumentPassportNumber,
      allowToUpdateDocumentPassportCountry: legacyAuthorizationModel.allowToUpdateDocumentPassportCountry,
      allowToUpdateDocumentPassportIssuingBody: legacyAuthorizationModel.allowToUpdateDocumentPassportIssuingBody,
      allowToUpdateDocumentPassportState: legacyAuthorizationModel.allowToUpdateDocumentPassportState,
      allowToUpdateDocumentPassportIssuanceDate: legacyAuthorizationModel.allowToUpdateDocumentPassportIssuanceDate,
      allowToUpdateDocumentPassportExpiryDate: legacyAuthorizationModel.allowToUpdateDocumentPassportExpiryDate,
      allowToUpdateDocumentNisNumber: legacyAuthorizationModel.allowToUpdateDocumentNisNumber,
      allowToUpdateDocumentNisRegistrationDate: legacyAuthorizationModel.allowToUpdateDocumentNisRegistrationDate,
      allowToUpdateDocumentReservistNumber: legacyAuthorizationModel.allowToUpdateDocumentReservistNumber,
      allowToUpdateDocumentReservistCategory: legacyAuthorizationModel.allowToUpdateDocumentReservistCategory,
      allowToUpdateDocumentCnsNumber: legacyAuthorizationModel.allowToUpdateDocumentCnsNumber,
      allowToUpdateDocumentCertificate: legacyAuthorizationModel.allowToUpdateDocumentCertificate,
      allowToUpdateDocumentAttachment: legacyAuthorizationModel.allowToUpdateDocumentAttachment,
      allowToUpdateDocumentNotes: legacyAuthorizationModel.allowToUpdateDocumentNotes,
      allowToUpdateDocumentVisaNumber: legacyAuthorizationModel.allowToUpdateDocumentVisaNumber,
      allowToUpdateDocumentVisaIssuedDate: legacyAuthorizationModel.allowToUpdateDocumentVisaIssuedDate,
      allowToUpdateDocumentVisaExpiryDate: legacyAuthorizationModel.allowToUpdateDocumentVisaExpiryDate,
      allowToUpdateDocumentVisaType: legacyAuthorizationModel.allowToUpdateDocumentVisaType,
      allowToUpdateDocumentRneNumber: legacyAuthorizationModel.allowToUpdateDocumentRneNumber,
      allowToUpdateDocumentRneIssuingBody: legacyAuthorizationModel.allowToUpdateDocumentRneIssuingBody,
      allowToUpdateDocumentRneIssuedDate: legacyAuthorizationModel.allowToUpdateDocumentRneIssuedDate,
      allowToUpdateAddressZipCode: legacyAuthorizationModel.allowToUpdateAddressZipCode,
      allowToUpdateAddressPatioType: legacyAuthorizationModel.allowToUpdateAddressPatioType,
      allowToUpdateAddressPatio: legacyAuthorizationModel.allowToUpdateAddressPatio,
      allowToUpdateAddressNumber: legacyAuthorizationModel.allowToUpdateAddressNumber,
      allowToUpdateAddressAdditional: legacyAuthorizationModel.allowToUpdateAddressAdditional,
      allowToUpdateAddressNeighborhood: legacyAuthorizationModel.allowToUpdateAddressNeighborhood,
      allowToUpdateAddressCity: legacyAuthorizationModel.allowToUpdateAddressCity,
      allowToUpdateAddressAdmRegion: legacyAuthorizationModel.allowToUpdateAddressAdmRegion,
      allowToUpdateAddressNotes: legacyAuthorizationModel.allowToUpdateAddressNotes,
      allowToUpdateEmergencyContactPhoneDDD: legacyAuthorizationModel.allowToUpdateEmergencyContactPhoneDDD,
      allowToUpdateEmergencyContactPhoneDDI: legacyAuthorizationModel.allowToUpdateEmergencyContactPhoneDDI,
      allowToUpdateEmergencyContactPhoneExtension: legacyAuthorizationModel.allowToUpdateEmergencyContactPhoneExtension,
      allowToUpdateEmergencyContactPhoneGender: legacyAuthorizationModel.allowToUpdateEmergencyContactPhoneGender,
      allowToUpdateEmergencyContactPhoneKinship: legacyAuthorizationModel.allowToUpdateEmergencyContactPhoneKinship,
      allowToUpdateEmergencyContactPhoneName: legacyAuthorizationModel.allowToUpdateEmergencyContactPhoneName,
      allowToUpdateEmergencyContactPhoneNumber: legacyAuthorizationModel.allowToUpdateEmergencyContactPhoneNumber,
      allowToUpdateEmergencyContactPhoneProvider: legacyAuthorizationModel.allowToUpdateEmergencyContactPhoneProvider,
      allowToViewWorkContract: platformWorkContractView,
    );
  }
}
