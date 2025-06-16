import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter/foundation.dart';
import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:share_plus_platform_interface/share_plus_platform_interface.dart';

import '../../../ponto_mobile_collector.dart';
import '../modules/about/domain/presenter/cubit/about_cubit.dart';
import '../modules/clocking_event/domain/usecase/call_facial_recognition_config_usecase.dart';
import '../modules/clocking_event/domain/usecase/check_employee_in_fences_usecase.dart';
import '../modules/clocking_event/domain/usecase/employee_has_recent_clocking_event_usecase.dart';
import '../modules/clocking_event/domain/usecase/employee_has_reminder_clocking_event_usecase.dart';
import '../modules/clocking_event/domain/usecase/get_clock_observable_usecase.dart';
import '../modules/clocking_event/domain/usecase/get_clock_time_usecase.dart';
import '../modules/clocking_event/domain/usecase/get_lifecycle_stream_usecase.dart';
import '../modules/clocking_event/domain/usecase/get_receipt_usecase.dart';
import '../modules/clocking_event/domain/usecase/init_clock_usecase.dart';
import '../modules/clocking_event/domain/usecase/register_clocking_event_usecase.dart';
import '../modules/clocking_event/domain/usecase/synchronize_clocking_event_usecase.dart';
import '../modules/clocking_event/domain/usecase/take_photo_config_usecase.dart';
import '../modules/clocking_event/domain/util/clocking_event_util.dart';
import '../modules/clocking_event/domain/util/iclocking_event_utill.dart';
import '../modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_camera_permission_node.dart';
import '../modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_employee_node.dart';
import '../modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_facial_recognition_state_node.dart';
import '../modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_fence_status_state_node.dart';
import '../modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_location_permission_node.dart';
import '../modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_location_state_node.dart';
import '../modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_photo_state_node.dart';
import '../modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_recent_status_state_node.dart';
import '../modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_reminder_status_state_node.dart';
import '../modules/clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_bloc.dart';
import '../modules/device_configuration_permission/domain/presenter/cubit/device_configuration_permission_cubit.dart';
import '../modules/facial_recognition/domain/usecases/get_facial_recognition_failure_reason_usecase.dart';
import '../modules/notification/binds/notification_domain_binds.dart';
import '../modules/notification/binds/notification_external_binds.dart';
import '../modules/notification/binds/notification_infra_binds.dart';
import '../modules/notification/binds/notification_presenter_binds.dart';
import '../modules/privacy_policy/domain/presenter/cubit/privacy_policy_cubit.dart';
import '../modules/time_adjustment/domain/usecases/get_employees_by_manager_usecase.dart';
import '../modules/time_adjustment/domain/usecases/get_employees_to_completed_appointments_usecase.dart';
import 'domain/repositories/check_feature_toggle_repository.dart';
import 'domain/repositories/check_user_permission_repository.dart';
import 'domain/repositories/database/clocking_event_use_repository.dart';
import 'domain/repositories/database/i_device_configuration_repository.dart';
import 'domain/repositories/database/iemployee_platform_user_repository.dart';
import 'domain/repositories/database/imanager_employee_repository.dart';
import 'domain/repositories/database/imanager_repository.dart';
import 'domain/repositories/database/iplatform_user_repository.dart';
import 'domain/repositories/database/ireminder_repository.dart';
import 'domain/repositories/database/logs_repository_db.dart';
import 'domain/repositories/database/privacy_policy_repository.dart';
import 'domain/repositories/face_recognition_check_face_repository.dart';
import 'domain/repositories/face_recognition_register_company_repository.dart';
import 'domain/repositories/face_recognition_register_face_repository.dart';
import 'domain/repositories/face_recognition_sync_face_repository.dart';
import 'domain/repositories/face_recognition_token_repository.dart';
import 'domain/repositories/get_global_device_configuration_repository.dart';
import 'domain/repositories/get_platform_menu_app_repository.dart';
import 'domain/repositories/mobile_login_repository.dart';
import 'domain/repositories/request_device_permissions_repository.dart';
import 'domain/repositories/sync_logs_api_repository.dart';
import 'domain/services/face_recognition/face_recognition_authenticate_service.dart';
import 'domain/services/face_recognition/face_recognition_download_service.dart';
import 'domain/services/face_recognition/face_recognition_settings_service.dart';
import 'domain/services/face_recognition/face_recognition_synchronization_service.dart';
import 'domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import 'domain/services/http_client/i_http_client.dart';
import 'domain/services/lifecycle/ilifecycle_service.dart';
import 'domain/services/logs/delete_logs_service.dart';
import 'domain/services/logs/get_logs_service.dart';
import 'domain/services/logs/send_logs_service.dart.dart';
import 'domain/services/logs/sync_logs_api_service.dart';
import 'domain/services/navigator/navigator_service.dart';
import 'domain/services/privacy_policy_service/privacy_policy_service.dart';
import 'domain/services/work_indicator_service.dart';
import 'domain/usecases/check_conection_usecase.dart';
import 'domain/usecases/check_feature_toggle_usecase.dart';
import 'domain/usecases/check_need_facial_recognition_by_clocking_event_use_usecase.dart';
import 'domain/usecases/check_user_is_employee_usecase.dart';
import 'domain/usecases/check_user_permission_usecase.dart';
import 'domain/usecases/deauthenticate_user_usecase.dart';
import 'domain/usecases/find_employee_by_username_usecase.dart';
import 'domain/usecases/get_access_token_usecase.dart';
import 'domain/usecases/get_acess_token_username_usecase.dart';
import 'domain/usecases/get_clocking_event_use_usecase.dart';
import 'domain/usecases/get_employee_manager_usecase.dart';
import 'domain/usecases/get_environment_usecase.dart';
import 'domain/usecases/get_execution_mode_usecase.dart';
import 'domain/usecases/get_facial_recognition_is_enable_usecase.dart';
import 'domain/usecases/get_global_device_configuration_usecase.dart';
import 'domain/usecases/get_location_usecase.dart';
import 'domain/usecases/get_logs_usecase.dart';
import 'domain/usecases/get_platform_menus_usecase.dart';
import 'domain/usecases/get_session_employee_usecase.dart';
import 'domain/usecases/initialize_facial_recognition_usecase.dart';
import 'domain/usecases/load_user_permissions_usecase.dart';
import 'domain/usecases/logoff_usecase.dart';
import 'domain/usecases/mobile_login_usecase.dart';
import 'domain/usecases/refresh_access_token_usecase.dart';
import 'domain/usecases/remove_application_key_usecase.dart';
import 'domain/usecases/send_logs_usecase.dart';
import 'domain/usecases/sync_all_individual_info_usecase.dart';
import 'domain/usecases/sync_employee_by_id_usecase.dart';
import 'domain/usecases/sync_face_employee_usecase.dart';
import 'domain/usecases/sync_logs_api_usecase.dart';
import 'domain/usecases/sync_multiple_face_employees_usecase.dart';
import 'domain/usecases/sync_overnight_usecase.dart';
import 'external/datasources/check_feature_toggle_datasource_impl.dart';
import 'external/datasources/check_user_permission_datasource_impl.dart';
import 'external/datasources/face_recognition_register_company_datasource_impl.dart';
import 'external/datasources/face_recognition_register_face_datasource_impl.dart';
import 'external/datasources/face_recognition_token_datasource_impl.dart';
import 'external/datasources/get_device_datasource_impl.dart';
import 'external/datasources/get_global_device_configuration_datasource_impl.dart';
import 'external/datasources/mobile_login_datasource_impl.dart';
import 'external/datasources/platform_menu_app_datasource_impl.dart';
import 'external/datasources/sync_logs_api_datasource_impl.dart';
import 'external/drift/database.dart';
import 'external/flutter_gryfo_lib.dart';
import 'external/mappers/activation_mapper.dart';
import 'external/mappers/clocking_event_mapper.dart';
import 'external/mappers/clocking_event_use_mapper.dart';
import 'external/mappers/company_mapper.dart';
import 'external/mappers/configuration_mapper.dart';
import 'external/mappers/device_mapper.dart';
import 'external/mappers/employee_mapper.dart';
import 'external/mappers/fence_mapper.dart';
import 'external/mappers/global_configuration_mapper.dart';
import 'external/mappers/global_device_configuration_entity_mapper.dart';
import 'external/mappers/manager_mapper.dart';
import 'external/mappers/mobile_login_configuration_mapper.dart';
import 'external/mappers/perimeter_mapper.dart';
import 'external/mappers/platform_user_mapper.dart';
import 'helper/database_helper.dart';
import 'infra/adapters/user_permissions_entity_adapter.dart';
import 'infra/datasources/check_feature_toggle_datasource.dart';
import 'infra/datasources/check_user_permission_datasource.dart';
import 'infra/datasources/face_recognition_register_company_datasource.dart';
import 'infra/datasources/face_recognition_register_face_datasource.dart';
import 'infra/datasources/face_recognition_token_datasource.dart';
import 'infra/datasources/get_device_datasource.dart';
import 'infra/datasources/get_global_device_configuration_datasource.dart';
import 'infra/datasources/mobile_login_datasource.dart';
import 'infra/datasources/platform_menu_app_datasource.dart';
import 'infra/datasources/sync_logs_api_datasource.dart';
import 'infra/repositories/check_feature_toggle_repository_impl.dart';
import 'infra/repositories/check_user_permission_repository_impl.dart';
import 'infra/repositories/database/clocking_event_use_repository.dart';
import 'infra/repositories/database/employee_platform_user_repository.dart';
import 'infra/repositories/database/global_configuration_repository.dart';
import 'infra/repositories/database/journey_repository.dart';
import 'infra/repositories/database/logs_repository_db_impl.dart';
import 'infra/repositories/database/manager_employee_repository.dart';
import 'infra/repositories/database/manager_platform_user_repository.dart';
import 'infra/repositories/database/manager_repository.dart';
import 'infra/repositories/database/overnight_repository.dart';
import 'infra/repositories/database/platform_user_repository.dart';
import 'infra/repositories/database/privacy_policy_repository_impl.dart';
import 'infra/repositories/database/reminder_repository.dart';
import 'infra/repositories/face_recognition_check_face_repository_impl.dart';
import 'infra/repositories/face_recognition_register_company_repository_impl.dart';
import 'infra/repositories/face_recognition_register_face_repository_impl.dart';
import 'infra/repositories/face_recognition_sync_face_repository_impl.dart';
import 'infra/repositories/face_recognition_token_repository_impl.dart';
import 'infra/repositories/get_global_device_configuration_repository_impl.dart';
import 'infra/repositories/get_platform_menu_app_repository.dart';
import 'infra/repositories/mobile_login_repository_impl.dart';
import 'infra/repositories/request_device_permissions_repository_impl.dart';
import 'infra/repositories/sync_logs_api_repository_impl.dart';
import 'infra/services/face_recognition/face_recognition_authenticate_service_impl.dart';
import 'infra/services/face_recognition/face_recognition_download_service_impl.dart';
import 'infra/services/face_recognition/face_recognition_sdk_authentication_service.dart';
import 'infra/services/face_recognition/face_recognition_settings_service_impl.dart';
import 'infra/services/face_recognition/face_recognition_synchronization_service_impl.dart';
import 'infra/services/firebase/log_service_impl.dart';
import 'infra/services/http_client/http_client.dart';
import 'infra/services/http_client/interceptors/token_interceptor.dart';
import 'infra/services/http_client/policies/expired_token_retry_policy.dart';
import 'infra/services/lifecycle/lifecycle_service.dart';
import 'infra/services/logs/delete_logs_service_impl.dart';
import 'infra/services/logs/get_logs_service_impl.dart';
import 'infra/services/logs/send_logs_service_impl.dart';
import 'infra/services/logs/sync_logs_api_service_impl.dart';
import 'infra/services/navigator/navigator_service_impl.dart';
import 'infra/services/privacy_policy/privacy_policy_service_impl.dart';
import 'infra/services/work_indicator_service_impl.dart';
import 'presenter/cubit/hub_menu_cubit.dart';
import 'presenter/cubit/sync_all_individual_info/sync_all_individual_info_cubit.dart';
import 'presenter/cubit/work_indicator/work_indicator_cubit.dart';
import 'presenter/widgets/code_scanner/cubit/code_scanner_cubit.dart';
import 'presenter/widgets/collector_camera/request_camera_permissions_modal_widget.dart';

class PontoMobileCollectorBinds extends Module {
  // Bind.singleton : Crie uma instância apenas uma vez quando o módulo for iniciado.
  // Bind.lazySingleton : Crie uma instância apenas uma vez quando solicitado.
  // Bind.factory : Crie uma instância sob demanda.
  // Bind.instance : Adiciona uma instância existente.

  @override
  List<Bind> get binds => [
        /// MAPPERS
        Bind.lazySingleton<MobileLoginConfigurationMapper>(
          (i) => MobileLoginConfigurationMapper(),
          export: true,
        ),

        Bind.lazySingleton<ConfigurationMapper>(
          (i) => ConfigurationMapper(),
          export: true,
        ),
        Bind.lazySingleton<ClockingEventUseMapper>(
          (i) => ClockingEventUseMapper(),
          export: true,
        ),
        Bind.lazySingleton<ActivationMapper>(
          (i) => ActivationMapper(),
          export: true,
        ),

        Bind.lazySingleton<GlobalConfigurationEntityMapper>(
          (i) => GlobalConfigurationEntityMapper(),
          export: true,
        ),

        Bind.lazySingleton<DeviceMapper>(
          (i) => DeviceMapper(),
          export: true,
        ),

        Bind.lazySingleton<PerimeterMapper>(
          (i) => PerimeterMapper(),
          export: true,
        ),
        Bind.lazySingleton<FenceMapper>(
          (i) => FenceMapper(),
          export: true,
        ),
        Bind.lazySingleton<ManagerMapper>(
          (i) => ManagerMapper(),
          export: true,
        ),
        Bind.lazySingleton<PlatformUserMapper>(
          (i) => PlatformUserMapper(),
          export: true,
        ),
        Bind.lazySingleton<EmployeeMapper>(
          (i) => EmployeeMapper(),
          export: true,
        ),
        Bind.lazySingleton<CompanyMapper>(
          (i) => CompanyMapper(),
          export: true,
        ),

        Bind.lazySingleton<GlobalDeviceConfigurationEntityMapper>(
          (i) => GlobalDeviceConfigurationEntityMapper(),
          export: true,
        ),

        /// ADAPTERS
        Bind.lazySingleton<UserPermissionsEntityAdapter>(
          (i) => UserPermissionsEntityAdapter(),
          export: true,
        ),

        /// DATASOURCES

        Bind.lazySingleton<MobileLoginDataSource>(
          (i) => MobileLoginDataSourceImpl(
            mobileAuthenticationService: i(),
            mobileLoginConfiguratioMapper: i(),
            platformService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetGlobalDeviceConfigurationDatasource>(
          (i) => GetGlobalDeviceConfigurationDatasourceImpl(
            environmentService: i(),
            httpClient: i(),
            globalDeviceConfigurationEntityMapper: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<FaceRecognitionRegisterFaceDatasource>(
          (i) => FaceRecognitionRegisterFaceDatasourceImpl(
            environmentService: i(),
            httpClient: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<FaceRecognitionTokenDatasource>(
          (i) => FaceRecognitionTokenDatasourceImpl(
            environmentService: i(),
            httpClient: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<FaceRecognitionRegisterCompanyDatasource>(
          (i) => FaceRecognitionRegisterCompanyDatasourceImpl(
            environmentService: i(),
            httpClient: i(),
            sharedPreferencesService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<CheckUserPermissionDatasource>(
          (i) => CheckUserPermissionDatasourceImpl(
            environmentService: i(),
            mobileAuthenticationService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<CheckFeatureToggleDatasource>(
          (i) => CheckFeatureToggleDatasourceImpl(
            environmentService: i(),
            httpClient: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<CheckUserPermissionDatasource>(
          (i) => CheckUserPermissionDatasourceImpl(
            environmentService: i(),
            mobileAuthenticationService: i(),
          ),
          export: true,
        ),

        /// REPOSITORIES
        Bind.lazySingleton<MobileLoginRepository>(
          (i) => MobileLoginRepositoryImpl(
            i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<GetGlobalDeviceConfigurationRepository>(
          (i) => GetGlobalDeviceConfigurationRepositoryImpl(
            getDeviceConfigurationDatasource: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<PrivacyPolicyRepository>(
          (i) => PrivacyPolicyRepositoryImpl(
            database: localDatabase,
          ),
          export: true,
        ),

        Bind.lazySingleton<FaceRecognitionSyncFaceRepository>(
          (i) => FaceRecognitionSyncFaceRepositoryImpl(
            gryfoLib: i(),
            logService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<FaceRecognitionCheckFaceRepository>(
          (i) => FaceRecognitionCheckFaceRepositoryImpl(
            gryfoLib: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<FaceRecognitionRegisterFaceRepository>(
          (i) => FaceRecognitionRegisterFaceRepositoryImpl(
            faceRecognitionRegisterFaceDatasource: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<FaceRecognitionRegisterCompanyRepository>(
          (i) => FaceRecognitionRegisterCompanyRepositoryImpl(
            faceRecognitionRegisterCompanyDatasource: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<FaceRecognitionTokenRepository>(
          (i) => FaceRecognitionTokenRepositoryImpl(
            getFaceRecognitionTokenDatasource: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IHttpClient>(
          (i) => HttpClient(i()),
          export: true,
        ),

        Bind.lazySingleton<IClockingEventRepository>(
          (i) => ClockingEventRepository(
            database: localDatabase,
            companyRepository: i(),
            employeeRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<ICompanyRepository>(
          (i) => CompanyRepository(database: localDatabase),
          export: true,
        ),

        Bind.lazySingleton<IConfigurationRepository>(
          (i) => ConfigurationRepository(database: localDatabase),
          export: true,
        ),

        Bind.lazySingleton<IEmployeeFenceRepository>(
          (i) => EmployeeFenceRepository(database: localDatabase),
          export: true,
        ),

        Bind.lazySingleton<IFencePerimeterRepository>(
          (i) => FencePerimeterRepository(database: localDatabase),
          export: true,
        ),

        Bind.lazySingleton<IPerimeterRepository>(
          (i) => PerimeterRepository(
            database: localDatabase,
            fencePerimeterRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IFenceRepository>(
          (i) => FenceRepository(
            database: localDatabase,
            employeeFenceRepository: i(),
            fencePerimeterRepository: i(),
            perimeterRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IDeviceRepository>(
          (i) => DeviceRepository(
            database: localDatabase,
            deviceEntityMapper: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IActivationRepository>(
          (i) => ActivationRepository(database: localDatabase),
          export: true,
        ),

        Bind.lazySingleton<IManagerEmployeeRepository>(
          (i) => ManagerEmployeeRepository(
            database: localDatabase,
          ),
          export: true,
        ),

        Bind.lazySingleton<IManagerPlatformUserRepository>(
          (i) => ManagerPlatformUserRepository(
            database: localDatabase,
            platformUserRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IPlatformUserRepository>(
          (i) => PlatformUserRepository(database: localDatabase),
          export: true,
        ),

        Bind.lazySingleton<IManagerRepository>(
          (i) => ManagerRepository(
            database: localDatabase,
            managerPlatformUserRepository: i(),
            managerEmployeeRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IEmployeePlatformUserRepository>(
          (i) => EmployeePlatformUserRepository(
            database: localDatabase,
          ),
          export: true,
        ),

        Bind.lazySingleton<IEmployeeRepository>(
          (i) => EmployeeRepository(
            companyRepository: i(),
            database: localDatabase,
            employeeFenceRepository: i(),
            fenceRepository: i(),
            managerEmployeeRepository: i(),
            managerRepository: i(),
            platformUserRepository: i(),
            employeePlatformUserRepository: i(),
            reminderRepository: i(),
            configurationRepository: i(),
            fencePerimeterRepository: i(),
            perimeterRepository: i(),
            managerPlatformUserRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IDeviceConfigurationRepository>(
          (i) => DeviceConfigurationRepository(localDatabase),
          export: true,
        ),

        Bind.lazySingleton<CheckFeatureToggleRepository>(
          (i) => CheckFeatureToggleRepositoryImpl(
            checkFeatureToggleDatasource: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<CheckUserPermissionRepository>(
          (i) => CheckUserPermissionRepositoryImpl(
            checkUserPermissionDatasource: i(),
            getAccessTokenUsecase: i(),
            userPermissionsEntityAdapter: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<CheckFeatureToggleRepository>(
          (i) => CheckFeatureToggleRepositoryImpl(
            checkFeatureToggleDatasource: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<RequestDevicePermissionRepository>(
          (i) => RequestDevicePermissionRepositoryImpl(
            permissionService: i(),
            sharedPreferencesService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IReminderRepository>(
          (i) => ReminderRepository(database: localDatabase),
          export: true,
        ),

        Bind.lazySingleton<ClockingEventUseRepository>(
          (i) => ClockingEventUseRepositoryImpl(database: localDatabase),
          export: true,
        ),

        Bind.lazySingleton<IJourneyRepository>(
          (i) => JourneyRepository(
            database: localDatabase,
          ),
          export: true,
        ),

        Bind.lazySingleton<IOvernightRepository>(
          (i) => OvernightRepository(
            database: localDatabase,
          ),
          export: true,
        ),

        Bind.lazySingleton<IReminderRepository>(
          (i) => ReminderRepository(database: localDatabase),
          export: true,
        ),

        Bind.lazySingleton<ClockingEventUseRepository>(
          (i) => ClockingEventUseRepositoryImpl(database: localDatabase),
          export: true,
        ),

        /// SERVICES
        Bind.lazySingleton<PrivacyPolicyService>(
          (i) => PrivacyPolicyServiceImpl(
            i(),
            i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<FaceRecognitionSynchronizationService>(
          (i) => FaceRecognitionSynchronizationServiceImpl(
            gryfoLib: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<FaceRecognitionDownloadService>(
          (i) => FaceRecognitionDownloadServiceImpl(
            gryfoLib: i(),
            sharedPreferencesService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<FaceRecognitionAuthenticateService>(
          (i) => FaceRecognitionAuthenticateServiceImpl(
            faceRecognitionTokenRepository: i(),
            gryfoLib: i(),
            sharedPreferencesService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<FaceRecognitionSettingsService>(
          (i) => FaceRecognitionSettingsServiceImpl(
            gryfoLib: i(),
            sharedPreferencesService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IPlatformService>(
          (i) => PlatformService(),
          onDispose: (service) => service.dispose(),
          export: true,
        ),

        Bind.lazySingleton<ISessionService>(
          (i) => SessionService.build(sharedPreferencesService: i()),
          export: true,
        ),

        Bind.lazySingleton<IMobileAuthenticationService>(
          (i) => MobileAuthenticationService(httpClient: i()),
          export: true,
        ),

        Bind.lazySingleton<IEnvironmentService>(
          (i) => EnvironmentService(),
          export: true,
        ),

        Bind.lazySingleton<IShareService>(
          (i) => ShareService(
            sharePlatform: SharePlatform.instance,
          ),
          export: true,
        ),

        Bind.lazySingleton<ISharedPreferencesService>(
          (i) => SharedPreferencesService(),
          export: true,
        ),

        Bind.lazySingleton<IPermissionService>(
          (i) => PermissionService(mobileAuthenticationService: i()),
          export: true,
        ),

        Bind.lazySingleton<clock.NTPService>(
          (i) => clock.NTPService(),
          export: true,
        ),

        Bind.lazySingleton<clock.IInternalClockService>(
          (i) => clock.InternalClockService(
            ntpService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IUtils>(
          (i) => Utils(),
          export: true,
        ),

        Bind.lazySingleton<ISynchronizeClockingEventService>(
          (i) => SynchronizeClockingEventService(
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<NavigatorService>(
          (i) => NavigatorServiceImpl(
            modularNavigator: Modular.to,
          ),
          export: true,
        ),

        Bind.lazySingleton<http.Client>(
          (i) => InterceptedClient.build(
            interceptors: [
              TokenInterceptor(
                getAccessTokenUsecase: i(),
                clearStoredDataUsecase: i(),
                navigatorService: i(),
                platformService: i(),
              ),
            ],
            retryPolicy: ExpiredTokenRetryPolicy(
              refreshAccessTokenUsecase: i(),
              authenticateRegisteredKeyUsecase: i(),
              getAccessTokenUsecase: i(),
            ),
          ),
          export: true,
        ),

        Bind.lazySingleton<clock.IDateTimeService>(
          (i) => clock.DateTimeService(
            httpService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<clock.IImportService>(
          (i) => clock.ImportService(
            httpService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetTokenUsecase>(
          (i) => GetTokenUsecaseImpl(
            getStoredKeyTokenUsecase: GetStoredKeyTokenUsecase(),
            getStoredTokenUsecase: GetStoredTokenUsecase(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetAccessTokenUsecase>(
          (i) => GetAccessTokenUsecaseImpl(
            getTokenUsecase: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<clock.IPhotoAwsS3Service>(
          (i) => clock.PhotoAwsS3Service(
            httpService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IUploadPhotosService>(
          (i) => UploadPhotosService(
            i(),
            i(),
            i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<ILifecycleService>(
          (i) => LifecycleService(),
          export: true,
        ),

        Bind.lazySingleton<FlutterGryfoLib>(
          (i) => pontoFlutterGryfoLib,
          export: true,
        ),

        Bind.lazySingleton<IFaceRecognitionSdkAuthenticationService>(
          (i) => FaceRecognitionSdkAuthenticationService(
            gryfoLib: i(),
            permissionService: i(),
            sessionService: i(),
            settingsService: i(),
            faceRecognitionAuthenticateService: i(),
            faceRecognitionRegisterCompanyRepository: i(),
            faceRecognitionDownloadService: i(),
            faceRecognitionSynchronizationService: i(),
            faceRecognitionCheckFaceRepository: i(),
            getTokenUsecase: i(),
            sharedPreferencesService: i(),
            workIndicatorService: i(),
            hasConnectivityUsecase: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IApplicationRepository>(
          (i) => ApplicationRepository(database: localDatabase),
          export: true,
        ),
        Bind.singleton<ICollectorModuleService>(
          (i) => CollectorModuleService(
            activationRepository: i(),
            configurationRepository: i(),
            employeeRepository: i(),
            getTokenUsecase: i(),
            initializeFacialRecognitionUsecase: i(),
            initClockUsecase: i(),
            platformService: i(),
            sessionService: i(),
            synchronizeClockingEventService: i(),
            mobileLoginUsecase: i(),
            requestDevicePermissionRepository: i(),
            getLastVersionPrivacyPolicyUsecase: i(),
          ),
          export: true,
        ),

        // USECASES
        Bind.lazySingleton<GetLastVersionPrivacyPolicyUsecase>(
          (i) => GetLastVersionPrivacyPolicyUsecaseImpl(
            privacyPolicyService: i(),
            privacyPolicyRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<CheckUserIsEmployeeUsecase>(
          (i) => CheckUserIsEmployeeUsecaseImpl(
            employeePlatformUserRepository: i(),
            platformUserRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<CheckFeatureToggleUsecase>(
          (i) => CheckFeatureToggleUsecaseImpl(
            checkFeatureToggleRepository: i(),
            getAccessTokenUsecase: i(),
            hasConnectivityUsecase: i(),
            sharedPreferencesService: i(),
            getExecutionModeUsecase: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetFacialRecognitionIsEnableUsecase>(
          (i) => GetFacialRecognitionIsEnableUsecaseImpl(
            configurationRepository: i(),
            getAccessTokenUsecase: i(),
            getExecutionModeUsecase: i(),
            getSessionEmployeeUsecase: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetEmployeeManagerUsecase>(
          (i) => GetEmployeeManagerUsecaseImpl(
            employeeRepository: i(),
            employeePlatformUserRepository: i(),
            platformUserRepository: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<GetEmployeesByManagerUsecase>(
          (i) => GetEmployeesByManagerUsecaseImpl(
            employeeRepository: i(),
            managerRepository: i(),
            platformUserRepository: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<GetEmployeesToCompletedAppointmentsUsecase>(
          (i) => GetEmployeesToCompletedAppointmentsUsecaseImpl(
            getEmployeesToCompletedAppointmentsByManagerUseCase: i(),
            employeeRepository: i(),
            clockingEventRepository: i(),
            getEmployeeManagerUsecase: i(),
            checkUserPermissionUsecase: i(),
            verifyUserLoggedIsManagerUsecase: i(),
            verifyUserLoggedIsAdminUsecase: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<DeauthenticateUserUsecase>(
          (i) => DeauthenticateUserUsecaseImpl(
            authenticationBloc: i(),
            getTokenUsecase: i(),
            sessionService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetAllowGpoOnAppUsecase>(
          (i) => GetAllowGpoOnAppUsecaseimpl(configurationRepository: i()),
          export: true,
        ),
        Bind.lazySingleton<GetGlobalDeviceConfigurationUsecase>(
          (i) => GetGlobalDeviceConfigurationUsecaseImpl(
            deviceConfigurationRepository: i(),
            getGlobalDeviceConfigurationRepository: i(),
            globalConfigurationRepository: i(),
            platformService: i(),
            deviceRepository: i(),
            getAccessTokenUsecase: i(),
            initClockUsecase: i(),
            logService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetStoredKeyUsecase>(
          (i) => GetStoredKeyUsecase(),
          export: true,
        ),

        Bind.lazySingleton<ClearStoredDataUsecase>(
          (i) => ClearStoredDataUsecase(),
          export: true,
        ),

        Bind.lazySingleton<RefreshKeyStoredTokenUsecase>(
          (i) => RefreshKeyStoredTokenUsecase(),
          export: true,
        ),

        Bind.lazySingleton<RefreshStoredTokenUsecase>(
          (i) => RefreshStoredTokenUsecase(),
          export: true,
        ),

        Bind.lazySingleton<RefreshAccessTokenUsecase>(
          (i) => RefreshAccessTokenUsecaseImpl(
            getTokenUsecase: i(),
            refreshKeyStoredTokenUsecase: i(),
            refreshStoredTokenUsecase: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IGetClockObservableUsecase>(
          (i) => GetClockObservableUsecase(
            internalClockService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IGetClockDateTimeUsecase>(
          (i) => GetClockDateTimeUsecase(
            internalClockService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IRegisterClockingEventUsecase>(
          (i) => RegisterClockingEventUsecase(
            registerClockingEventService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IRegisterClockingEventService>(
          (i) => RegisterClockingEventService(
            clockingEventRepository: i(),
            createClockingEventService: i(),
            environmentService: i(),
            internalClockService: i(),
            platformService: i(),
            synchronizeClockingEventService: i(),
            utils: i(),
            configurationRepository: i(),
            getAccessTokenUsecase: i(),
            clockingEventUseRepository: i(),
            logService: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<clock.ICreateClockingEventService>(
          (i) => clock.CreateClockingEventService.instance,
          export: true,
        ),

        Bind.lazySingleton<IInitClockUsecase>(
          (i) => InitClockUsecase(
            internalClockService: i(),
            sessionService: i(),
            getAccessTokenUsecase: i(),
            getExecutionModeUsecase: i(),
            deviceConfigurationRepository: i(),
            platformService: i(),
            configurationRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IGetLifecycleStreamUsecase>(
          (i) => GetLifecycleStreamUsecase(
            lifecycleService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<ISynchronizeClockingEventUsecase>(
          (i) => SynchronizeClockingEventUsecase(
            synchronizeClockingEventService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IGetUserFaceRecognitionUsecase>(
          (i) => GetUserFaceRecognitionUsecase(
            getSessionEmployeeUsecase: i(),
            configurationRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<CheckUserPermissionUsecase>(
          (i) => CheckUserPermissionUsecaseImpl(
            checkUserPermissionRepository: i(),
            getExecutionModeUsecase: i(),
            sessionService: i(),
            sharedPreferencesService: i(),
            hasConnectivityUsecase: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<CheckFeatureToggleUsecase>(
          (i) => CheckFeatureToggleUsecaseImpl(
            checkFeatureToggleRepository: i(),
            getAccessTokenUsecase: i(),
            hasConnectivityUsecase: i(),
            sharedPreferencesService: i(),
            getExecutionModeUsecase: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetEnvironmentUsecase>(
          (i) => GetEnvironmentUsecaseImpl(
            environmentService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetSessionEmployeeUsecase>(
          (i) => GetSessionEmployeeUsecaseImpl(
            sessionService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IClockingEventUtil>(
          (i) => ClockingEventUtil(),
          export: true,
        ),

        Bind.lazySingleton<GetFacialRecognitionStateNode>(
          (i) => GetFacialRecognitionStateNode(
            callFacialRecognitionConfigUsecase: i(),
            getExecutionModeUsecase: i(),
            checkNeedFacialRecognitionByClockingEventTypeUsecase: i(),
            permissionService: i(),
            navigatorService: i(),
            logService: i(),
            getFacialRecognitionFailureReasonUsecase: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<ITakePhotoConfigUsecase>(
          (i) => TakePhotoConfigUsecase(
            sessionService: i(),
            getExecutionModeUsecase: i(),
            globalConfigurationRepository: i(),
            configurationRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<
            ICheckNeedFacialRecognitionByClockingEventTypeUsecase>(
          (i) => CheckNeedFacialRecognitionByClockingEventTypeUsecase(),
          export: true,
        ),

        Bind.lazySingleton<GetCameraPermissionNode>(
          (i) => GetCameraPermissionNode(
            permissionService: i(),
            navigatorService: i(),
            callFacialRecognitionConfigUsecase: i(),
            getExecutionModeUsecase: i(),
            takePhotoConfigUsecase: i(),
            logService: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<ICallFacialRecognitionConfigUsecase>(
          (i) => CallFacialRecognitionConfigUsecase(
            configurationRepository: i(),
            sharedPreferencesService: i(),
            platformService: i(),
            faceRecognitionSdkAuthenticationService: i(),
            permissionService: i(),
            checkUserPermissionUsecase: i(),
            employeeRepository: i(),
            faceRecognitionCheckFaceRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetFacialRecognitionFailureReasonUsecase>(
          (i) => GetFacialRecognitionFailureReasonUsecaseImpl(
            sharedPreferencesService: i(),
            faceRecognitionSdkAuthenticationService: i(),
            permissionService: i(),
            checkUserPermissionUsecase: i(),
            employeeRepository: i(),
            faceRecognitionCheckFaceRepository: i(),
            configurationRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetPhotoStateNode>(
          (i) => GetPhotoStateNode(
            permissionService: i(),
            takePhotoConfigUsecase: i(),
            checkNeedFacialRecognitionByClockingEventTypeUsecase: i(),
            navigatorService: i(),
            collectorCameraCubit: i(),
            logService: i(),
            cameraWidget: CameraWidget(
              cameraCubit: i(),
              navigatorService: i(),
              sessionService: i(),
              utils: i(),
            ),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetEmployeeNode>(
          (i) => GetEmployeeNode(
            employeeRepository: i(),
            sessionService: i(),
            logService: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<GetRecentStatusStateNode>(
          (i) => GetRecentStatusStateNode(
            employeeHasRecentClockingEventUsecase: i(),
            navigatorService: i(),
            logService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IEmployeeHasRecentClockingEventUsecase>(
          (i) => EmployeeHasRecentClockingEventUsecase(
            clockingEventRepository: i(),
            internalClockService: i(),
            sessionService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IEmployeeHasRecentClockingEventUsecase>(
          (i) => EmployeeHasRecentClockingEventUsecase(
            clockingEventRepository: i(),
            internalClockService: i(),
            sessionService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetLocationStateNode>(
          (i) => GetLocationStateNode(
            getLocationUsecase: i(),
            permissionService: i(),
            logService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetFenceStatusStateNode>(
          (i) => GetFenceStatusStateNode(
            checkEmployeeInFencesUsecase: i(),
            navigatorService: i(),
            logService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<ICheckEmployeeInFencesUsecase>(
          (i) => CheckEmployeeInFencesUsecase(
            clockingEventUtil: i(),
            createClockingEventService: i(),
            sessionService: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<GetLocationPermissionNode>(
          (i) => GetLocationPermissionNode(
            permissionService: i(),
            navigatorService: i(),
            logService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<InitializeFacialRecognitionUsecase>(
          (i) => InitializeFacialRecognitionUsecaseImpl(
            configurationRepository: i(),
            faceRecognitionSdkAuthenticationService: i(),
            getSessionEmployeeUsecase: i(),
            getExecutionModeUsecase: i(),
            getAccessTokenUsecase: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IGetReceiptUsecase>(
          (i) => GetReceiptUsecase(utils: i()),
          export: true,
        ),

        Bind.lazySingleton<GetExecutionModeUsecase>(
          (i) => GetExecutionModeUsecaseImpl(
            sessionService: i(),
            getTokenUsecase: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IHasConnectivityUsecase>(
          (i) => HasConnectivityUsecase(platformService: i()),
          export: true,
        ),

        Bind.lazySingleton<LoadUserPermissionsUsecase>(
          (i) => LoadUserPermissionsUsecaseImpl(
            checkUserPermissionUsecase: i(),
            hasConnectivityUsecase: i(),
            sharedPreferencesService: i(),
            getExecutionModeUsecase: i(),
            getAccessTokenUsernameUsecase: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<ILogoffUsecase>(
          (i) => LogoffUsecase(
            collectorModuleService: i(),
            gryfoLib: i(),
            sharedPreferencesService: i(),
            hasConnectivityUsecase: i(),
            getFacialRecognitionIsEnableUsecase: i(),
            deauthenticateUserUsecase: i(),
            logService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IEmployeeHasReminderClockingEventUseCase>(
          (i) => EmployeeHasReminderClockingEventUseCase(
            sessionService: i(),
            journeyRepository: i(),
            clockingEventRepository: i(),
            internalClockService: i(),
            reminderRepository: i(),
            utils: i(),
            clockingEventMapper: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetReminderStatusStateNode>(
          (i) => GetReminderStatusStateNode(
            employeeHasReminderClockingEventUseCase: i(),
            navigatorService: i(),
            logService: i(),
          ),
          export: true,
        ),

        // BLOC's
        Bind.lazySingleton<TimerBloc>(
          (i) => TimerBloc.getInstance(i(), i(), i(), i()),
          export: true,
        ),

        Bind.lazySingleton<SynchronizeClockingEventBloc>(
          (i) => SynchronizeClockingEventBloc(i()),
          export: true,
        ),

        Bind.lazySingleton<ISyncFaceEmployeeUsecase>(
          (i) => SyncFaceEmployeeUsecase(
            faceRecognitionSdkAuthenticationService: i(),
            sessionService: i(),
            sharedPreferencesService: i(),
            faceRecognitionRegisterCompanyRepository: i(),
            faceRecognitionCheckFaceRepository: i(),
            workIndicatorService: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton(
          (i) => CodeScannerCubit(
            sharedPreferencesService: i(),
            targetPlatform: defaultTargetPlatform,
            barcodeScanner: BarcodeScanner(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IGenerateJourneyIdUsecase>(
          (i) => GenerateJourneyIdUsecase(),
          export: true,
        ),

        Bind.lazySingleton<IRegisterJourneyUsecase>(
          (i) => RegisterJourneyUsecase(
            journeyRepository: i(),
            sessionService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IRegisterOvernightUsecase>(
          (i) => RegisterOvernightUsecase(
            overnightRepository: i(),
            syncOvernightUsecase: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IFinishJourneyUsecase>(
          (i) => FinishJourneyUsecase(
            journeyRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetEnvironmentUsecase>(
          (i) => GetEnvironmentUsecaseImpl(environmentService: i()),
          export: true,
        ),

        Bind.lazySingleton<GetEmployeeActivationUsecase>(
          (i) => GetEmployeeActivationUsecaseImpl(
            activationRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<CollectorCameraCubit>(
          (i) => CollectorCameraCubit(
            sharedPreferencesService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<DeviceConfigurationPermissionCubit>(
          (i) => DeviceConfigurationPermissionCubit(
            permissionService: i(),
            nfcManager: NfcManager.instance,
            getExecutionModeUsecase: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<PrivacyPolicyCubit>(
          (i) => PrivacyPolicyCubit(
            getLastVersionPrivacyPolicyUseCase: i(),
            privacyPolicyRepository: i(),
            hasConnectivityUsecase: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<ISyncMultipleFaceEmployeesUsecase>(
          (i) => SyncMultipleFaceEmployeesUsecase(
            faceRecognitionSyncFaceRepository: i(),
            employeeRepository: i(),
            logService: i(),
            workIndicatorService: i(),
            faceRecognitionSdkAuthenticationService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<MobileLoginUsecase>(
          (i) => MobileLoginUsecaseImpl(
            platformService: i(),
            employeeRepository: i(),
            configurationRepository: i(),
            activationRepository: i(),
            sharedPreferencesService: i(),
            managerPlatformUserRepository: i(),
            sessionService: i(),
            reminderRepository: i(),
            clockingEventUseRepository: i(),
            platformUserRepository: i(),
            loadUserPermissionsUsecase: i(),
            mobileLoginRepository: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<GetLocationUsecase>(
          (i) => GetLocationUsecaseImpl(
            platformService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<RequestCameraPermissionsModalWidget>(
          (i) => RequestCameraPermissionsModalWidget(
            permissionService: i(),
            navigatorService: i(),
            faceRecognitionSdkAuthenticationService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetPlatformMenuAppRepository>(
          (i) => GetPlatformMenuAppRepositoryImpl(
            i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetPlatformMenuAppRepository>(
          (i) => GetPlatformMenuAppRepositoryImpl(
            i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetPlatformMenusUsecase>(
          (i) => GetPlatformMenusUsecaseImpl(i(), i(), i()),
          export: true,
        ),

        Bind.lazySingleton<FindEmployeeIdByQrCodeUsecase>(
          (i) => FindEmployeeIdByQrCodeUsecaseImpl(
            employeeRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<FindEmployeeIdByUsernameUsecase>(
          (i) => FindEmployeeIdByUsernameUsecaseImpl(
            employeePlatformUserRepository: i(),
            platformUserRepository: i(),
            employeeRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<PlatformMenuAppDatasource>(
          (i) => PlatformMenuAppDatasourceImpl(
            httpClient: i(),
            environmentService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<HubMenuCubit>(
          (i) => HubMenuCubit(
            i(),
            i(),
            i(),
            i(),
            i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<GlobalConfigurationRepository>(
          (i) => GlobalConfigurationRepository(
            database: localDatabase,
            globalConfigurationEntityMapper: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<GetGlobalConfigurationUseCaseImpl>(
          (i) => GetGlobalConfigurationUseCaseImpl(
            platformService: i(),
            configurationGlobalQueryDatasource: i(),
            globalConfigurationRepository: i(),
            getAccessTokenUsecase: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<ConfigurationGlobalQueryDatasourceImpl>(
          (i) => ConfigurationGlobalQueryDatasourceImpl(
            httpClient: i(),
            environmentService: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<GetDeviceDatasource>(
          (i) => GetDeviceDatasourceImpl(
            environmentService: i(),
            httpClient: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<GetDeviceUsecaseImpl>(
          (i) => GetDeviceUsecaseImpl(
            deviceRepository: i(),
            // getDeviceDatasource: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<RegisterClockingEventBloc>(
          (i) => RegisterClockingEventBloc(
            getClockDateTimeUsecase: i(),
            registerClockingEventUsecase: i(),
            getRecentStatusStateNode: i(),
            getLocationStateNode: i(),
            getFacialRecognitionStateNode: i(),
            getFenceStatusStateNode: i(),
            getPhotoStateNode: i(),
            getEmployeeNode: i(),
            getLocationPermissionNode: i(),
            getCameraPermissionNode: i(),
            getReminderStatusStateNode: i(),
            logService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetAccessTokenUsernameUsecase>(
          (i) => GetAccessTokenUsernameUsecaseImpl(
            getTokenUsecase: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<LogsRepositoryDb>(
          (i) => LogsRepositoryDbImpl(database: localDatabase),
          export: true,
        ),

        Bind.lazySingleton<SyncLogsApiDatasource>(
          (i) => SyncLogsApiDatasourceImpl(
            environmentService: i(),
            httpClient: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<SyncLogsApiRepository>(
          (i) => SyncLogsApiRepositoryImpl(
            syncLogsApiDatasource: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<SendLogsService>(
          (i) => SendLogsServiceImpl(
            logsRepositoryDb: i(),
            logsRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<SendLogsUsecase>(
          (i) => SendLogsUsecaseImpl(
            getTokenUsecase: i(),
            sendLogsService: i(),
            platformService: i(),
            sessionService: i(),
            utils: i(),
            getExecutionModeUsecase: i(),
            getAccessTokenUsecase: i(),
            getClockDateTimeUsecase: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<LogService>(
          (i) => LogServiceImpl(
            sendLogsUsecase: i(),
            sharedPreferencesService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<SyncLogsApiService>(
          (i) => SyncLogsApiServiceImpl(syncLogsApiRepository: i()),
          export: true,
        ),
        Bind.lazySingleton<DeleteLogsService>(
          (i) => DeleteLogsServiceImpl(logsRepositoryDb: i()),
          export: true,
        ),
        Bind.lazySingleton<GetLogsService>(
          (i) => GetLogsServiceImpl(logsRepositoryDb: i()),
          export: true,
        ),
        Bind.lazySingleton<GetLogsUsecase>(
          (i) => GetLogsUsecaseImpl(logsRepositoryDb: i()),
          export: true,
        ),

        Bind.lazySingleton<SyncLogsApiUsecase>(
          (i) => SyncLogsApiUsecaseImpl(
            syncLogsApiService: i(),
            utils: i(),
            deleteLogsService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<WorkIndicatorService>(
          (i) => WorkIndicatorServiceImpl(),
          onDispose: (service) => service.dispose(),
          export: true,
        ),

        Bind.lazySingleton<WorkIndicatorCubit>(
          (i) => WorkIndicatorCubit(
            workIndicatorService: i(),
          ),
          onDispose: (cubit) => cubit.dispose(),
          export: true,
        ),

        Bind.lazySingleton<SyncAllIndividualInfoUsecase>(
          (i) => SyncAllIndividualInfoUsecaseImpl(
            getEnvironmentUsecase: i(),
            getTokenUsecase: i(),
            hasConnectivityUsecase: i(),
            initClockUsecase: i(),
            mobileLoginUsecase: i(),
            syncFaceEmployeeUsecase: i(),
            synchronizeClockingEventUsecase: i(),
            workIndicatorService: i(),
            logService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<clock.OvernightImportService>(
          (i) => clock.OvernightImportServiceImpl(
            httpService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<SyncAllIndividualInfoCubit>(
          (i) => SyncAllIndividualInfoCubit(
            syncAllIndividualInfoUsecase: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<SyncOvernightUsecase>(
          (i) => SyncOvernightUsecaseImpl(
            overnightRepository: i(),
            overnightImportService: i(),
            environmentService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetClockingEventUseUsecase>(
          (i) => GetClockingEventUseUsecaseImpl(
            clockingEventUseRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<ClearKeyStoredDataUsecase>(
          (i) => ClearKeyStoredDataUsecase(),
          export: true,
        ),

        Bind.lazySingleton<GetStoredKeyUsecase>(
          (i) => GetStoredKeyUsecase(),
          export: true,
        ),

        Bind.lazySingleton<RemoveApplicationKeyUsecase>(
          (i) => RemoveApplicationKeyUsecaseImpl(
            employeePlatformUserRepository: i(),
            employeeFenceRepository: i(),
            employeeRepository: i(),
            companyRepository: i(),
            managerPlatformUserRepository: i(),
            managerEmployeeRepository: i(),
            managerRepository: i(),
            platformUserRepository: i(),
            clockingEventRepository: i(),
            sharedPreferencesService: i(),
            clearKeyStoredDataUsecase: i(),
            getStoredKeyUsecase: i(),
            sessionService: i(),
            clearStoredDataUsecase: i(),
            authenticationBloc: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<AboutCubit>(
          (i) => AboutCubit(
            platformService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IEmployeeSyncService>(
          (i) => EmployeeSyncService(
            httpClient: i(),
            platformService: i(),
            sharedPreferencesService: i(),
            getEnviromentUsecase: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<SyncEmployeeByIdUsecase>(
          (i) => SyncEmployeeByIdUsecaseImpl(
            employeeSyncService: i(),
            workIndicatorService: i(),
            configurationRepository: i(),
            employeeRepository: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<AuthenticateKeyUsecase>(
          (i) => AuthenticateKeyUsecase(),
          export: true,
        ),

        Bind.lazySingleton<AuthenticateRegisteredKeyUsecase>(
          (i) => AuthenticateRegisteredKeyUsecaseImpl(
            authenticateKeyUsecase: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<ClockingEventMapper>(
          (i) => ClockingEventMapper(i(), i()),
          export: true,
        ),

        Bind.lazySingleton<IDatabaseHelper>(
          (i) => DatabaseHelper(
            database: localDatabase,
          ),
          export: true,
        ),

        ...NotificationDomainBinds.binds,
        ...NotificationInfraBinds.binds,
        ...NotificationExternalBinds.binds,
        ...NotificationPresenterBinds.binds,
      ];
}
