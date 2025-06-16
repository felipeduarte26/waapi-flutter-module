import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../core/services/has_clocking/infra/drivers/get_has_clocking_driver.dart';
import '../../../../core/services/has_clocking/infra/drivers/save_has_clocking_driver.dart';
import '../../../../core/services/has_clocking_configuration/external/get_clocking_configuration.dart';
import '../../../../core/services/has_clocking_configuration/infra/drivers/save_clocking_configuration_driver.dart';
import '../../../../core/services/internal_storage/internal_storage_service.dart';
import '../../../../core/services/rest_client/rest_service.dart';
import '../../../../core/types/either.dart';
import '../../domain/entities/authorization_entity.dart';
import '../../domain/entities/social_authorization_entity.dart';
import '../../domain/failures/authorization_failure.dart';
import '../../domain/repositories/authorization_repository.dart';
import '../adapters/authorization_entity_adapter.dart';
import '../datasources/active_tenant_modules_datasource.dart';
import '../datasources/feature_control_authorizations_datasource.dart';
import '../datasources/legacy_authorizations_datasource.dart';
import '../datasources/platform_authorizations_datasource.dart';
import '../drivers/get_waapi_lite_driver.dart';
import '../drivers/save_waapi_lite_driver.dart';
import '../models/feature_control_authorization_model.dart';
import '../models/legacy_authorization_model.dart';
import '../models/platform_authorization_model.dart';
import '../models/platform_authorizations_aggregator_model.dart';
import '../types/authorization_infra_types.dart';

class AuthorizationRepositoryImpl implements AuthorizationRepository {
  final LegacyAuthorizationsDatasource _legacyAuthorizationsDatasource;
  final PlatformAuthorizationsDatasource _platformAuthorizationsDatasource;
  final AuthorizationEntityAdapter _authorizationEntityMapper;

  final FeatureControlAuthorizationsDatasource _featureControlAuthorizationsDatasource;
  final ActiveTenantModulesDatasource _activeTenantModulesDatasource;

  final SaveWaapiLiteDriver _saveWaapiLiteDriver;
  final GetWaapiLiteDriver _getWaapiLiteDriver;
  final SaveHasClockingDriver _saveHasClockingDriver;
  final SaveClockingConfigurationDriver _saveClockingConfigurationDriver;
  final GetHasClockingDriver _getHasClockingDriver;
  final InternalStorageService _internalStorageService;
  final RestService _restService;

  const AuthorizationRepositoryImpl({
    required LegacyAuthorizationsDatasource legacyAuthorizationsDatasource,
    required PlatformAuthorizationsDatasource platformAuthorizationsDatasource,
    required AuthorizationEntityAdapter authorizationEntityMapper,
    required FeatureControlAuthorizationsDatasource featureControlAuthorizationsDatasource,
    required ActiveTenantModulesDatasource activeTenantModulesDatasource,
    required SaveWaapiLiteDriver saveWaapiLiteDriver,
    required GetWaapiLiteDriver getWaapiLiteDriver,
    required SaveHasClockingDriver saveHasClockingDriver,
    required SaveClockingConfigurationDriver saveClockingConfigurationDriver,
    required GetHasClockingDriver getHasClockingDriver,
    required InternalStorageService internalStorageService,
    required RestService restService,
  })  : _legacyAuthorizationsDatasource = legacyAuthorizationsDatasource,
        _platformAuthorizationsDatasource = platformAuthorizationsDatasource,
        _authorizationEntityMapper = authorizationEntityMapper,
        _featureControlAuthorizationsDatasource = featureControlAuthorizationsDatasource,
        _activeTenantModulesDatasource = activeTenantModulesDatasource,
        _saveWaapiLiteDriver = saveWaapiLiteDriver,
        _getWaapiLiteDriver = getWaapiLiteDriver,
        _saveHasClockingDriver = saveHasClockingDriver,
        _saveClockingConfigurationDriver = saveClockingConfigurationDriver,
        _getHasClockingDriver = getHasClockingDriver,
        _restService = restService,
        _internalStorageService = internalStorageService;

  @override
  GetUserAuthorizationRepositoryCallback call() async {
    late AuthorizationEntity authorizationEntity;
    try {
      bool hasClocking = false;
      bool hasClockingMobileLog = false;
      bool? isAllowGpoOnApp;

      final legacyAuthorizationModel = await _legacyAuthorizationsDatasource.call().onError((error, stackTrace) {
        return LegacyAuthorizationModel.empty();
      });

      final featureControlAuthorizationModel =
          await _featureControlAuthorizationsDatasource.call().onError((error, stackTrace) {
        return FeatureControlAuthorizationModel.empty();
      });

      final platformAuthorizationsAggregatorModel =
          await _platformAuthorizationsDatasource.call().onError((error, stackTrace) {
        return const PlatformAuthorizationsAggregatorModel(platformAuthorizations: []);
      });

      final isWaapiLite = await _activeTenantModulesDatasource.call().onError((error, stackTrace) {
        final isWaapiLite = _getWaapiLiteDriver.call();
        return isWaapiLite ?? false;
      });

      if (platformAuthorizationsAggregatorModel.platformAuthorizations.isEmpty) {
        hasClocking = _getHasClockingDriver.call() ?? false;
      } else {
        hasClocking =
            _checkAuthorization(platformAuthorizationsAggregatorModel.platformAuthorizations, 'pontomobile/employee');
      }

      if (platformAuthorizationsAggregatorModel.platformAuthorizations.isNotEmpty) {
        hasClockingMobileLog = _checkAuthorization(
          platformAuthorizationsAggregatorModel.platformAuthorizations,
          'pontomobile/entities/mobileLog',
        );
      }

      isAllowGpoOnApp = await GetClockingConfiguration(
        restService: _restService,
        internalStorageService: _internalStorageService,
        getStoredTokenUsecase: GetStoredTokenUsecase(),
      ).call();

      _saveWaapiLiteDriver(isWaapiLite: isWaapiLite);
      _saveHasClockingDriver(hasClocking: hasClocking);
      _saveClockingConfigurationDriver(key: 'allowGpoOnApp', allowGpoOnApp: isAllowGpoOnApp);

      if (legacyAuthorizationModel == LegacyAuthorizationModel.empty() ||
          featureControlAuthorizationModel == FeatureControlAuthorizationModel.empty() && !isWaapiLite) {
        authorizationEntity = AuthorizationEntity(
          allowToViewClockingMobileLog: hasClockingMobileLog,
          allowToViewMyFeedbacks: false,
          allowToViewMyFeedbacksRequests: false,
          allowToWriteFeedback: false,
          allowToRequestFeedback: false,
          allowToToggleInternalFeedbackSharing: false,
          allowToMakeFeedbackVisibleToEmployeeAndManager: false,
          allowToMakeFeedbackVisibleToEvaluator: false,
          allowToMakeFeedbackVisibleToManager: false,
          allowToMakeFeedbackVisibleToEmployee: false,
          allowToViewMyProfile: false,
          allowToViewVacations: false,
          allowToSearchPeople: false,
          allowToViewBirthdayCorporateMural: false,
          allowToViewCompanyBirthdayCorporateMural: false,
          allowToViewVacationAnalytics: false,
          allowEmployeeRequestVacation: false,
          show13thSalaryAdvance: false,
          showBonusDays: false,
          allowBonusDaysOnlyWhenThereIsBalance: false,
          vacationHelpDescription: null,
          allowCancellationScheduledVacation: false,
          allowToUpdatePersonalData: false,
          allowToUpdateEmergencyContact: false,
          allowToUpdatePersonalAddress: false,
          allowToUpdatePersonalContact: false,
          allowToUpdatePersonalDocuments: false,
          allowToViewCalendarVacations: false,
          allowToViewTimeManagement: hasClocking,
          allowToFinancialData: false,
          allowToUpdatePersonalDependents: false,
          allowToViewDependents: false,
          enableDependentIncomeTax: false,
          enablePersonalPhoto: false,
          allowToPayroll: false,
          allowToUpdatePersonalDataName: false,
          allowToUpdatePersonalDataNationality: false,
          allowToUpdatePersonalDataDisability: false,
          allowToUpdatePersonalDataRace: false,
          allowToUpdatePersonalDataBirthday: false,
          allowToUpdatePersonalDataNotes: false,
          allowToUpdatePersonalDataBirthplace: false,
          allowToUpdatePersonalDataEducationLevel: false,
          allowToUpdatePersonalDataMaritalStatus: false,
          allowToUpdatePersonalDataGender: false,
          allowToUpdateContactProfessionalEmail: false,
          allowToUpdateContactPersonalEmail: false,
          allowToUpdateContactPhoneType: false,
          allowToUpdateContactPhoneDDI: false,
          allowToUpdateContactPhoneDDD: false,
          allowToUpdateContactPhoneNumber: false,
          allowToUpdateContactPhoneExtension: false,
          allowToUpdateContactPhoneProvider: false,
          allowToUpdateContactPhoneAction: false,
          allowToUpdateContactEmailType: false,
          allowToUpdateContactEmailDescription: false,
          allowToUpdateContactEmailAction: false,
          allowToUpdateContactSocialNetworkType: false,
          allowToUpdateContactSocialNetworkUsername: false,
          allowToUpdateContactSocialNetworkAction: false,
          allowToUpdateContactNotes: false,
          allowToUpdateAddressZipCode: false,
          allowToUpdateAddressPatioType: false,
          allowToUpdateAddressPatio: false,
          allowToUpdateAddressNumber: false,
          allowToUpdateAddressAdditional: false,
          allowToUpdateAddressNeighborhood: false,
          allowToUpdateAddressCity: false,
          allowToUpdateAddressAdmRegion: false,
          allowToUpdateAddressNotes: false,
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
          allowToUpdateEmergencyContactPhoneDDI: false,
          allowToUpdateEmergencyContactPhoneDDD: false,
          allowToUpdateEmergencyContactPhoneNumber: false,
          allowToUpdateEmergencyContactPhoneExtension: false,
          allowToUpdateEmergencyContactPhoneProvider: false,
          allowToUpdateEmergencyContactPhoneKinship: false,
          allowToUpdateEmergencyContactPhoneName: false,
          allowToUpdateEmergencyContactPhoneGender: false,
          allowToViewVacationSignature: false,
          allowToViewHyperlinks: false,
          socialAuthorizationEntity: const SocialAuthorizationEntity(),
          isWaapiLite: isWaapiLite,
          allowToViewDiversity: false,
          allowToViewWorkContract: false,
        );
      } else {
        authorizationEntity = _authorizationEntityMapper.fromLegacyAndPlatform(
          legacyAuthorizationModel: legacyAuthorizationModel,
          platformAuthorizationsAggregatorModel: platformAuthorizationsAggregatorModel,
          featureControlAuthorizationModel: featureControlAuthorizationModel,
          isWaapiLite: isWaapiLite,
        );
      }

      return right(authorizationEntity);
    } catch (error) {
      return left(const UnknownAuthorizationFailure());
    }
  }

  bool _checkAuthorization(List<PlatformAuthorizationModel> authorizations, String resource) {
    for (final platformAuthorization in authorizations) {
      if (platformAuthorization.resource.contains(resource) && platformAuthorization.authorized) {
        return true;
      }
    }
    return false;
  }
}
