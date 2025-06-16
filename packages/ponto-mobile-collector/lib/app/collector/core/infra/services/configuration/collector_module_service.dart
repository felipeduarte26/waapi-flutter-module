import 'dart:io';

import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../../modules/clocking_event/domain/usecase/init_clock_usecase.dart';
import '../../../domain/entities/activation.dart';
import '../../../domain/entities/configuration.dart';
import '../../../domain/entities/mobile_login_usecase_return.dart';
import '../../../domain/input_model/activation_dto.dart';
import '../../../domain/input_model/configuration_dto.dart';
import '../../../domain/input_model/employee_dto.dart';
import '../../../domain/repositories/request_device_permissions_repository.dart';
import '../../../domain/usecases/initialize_facial_recognition_usecase.dart';
import '../../../domain/usecases/mobile_login_usecase.dart';
import '../../../external/mappers/activation_mapper.dart';
import '../../../external/mappers/configuration_mapper.dart';
import '../../../external/mappers/employee_mapper.dart';
class CollectorModuleService implements ICollectorModuleService {
  static AppIdentfierEnum appIdentfierEnum = AppIdentfierEnum.notSpecified;
  static bool _hasInitialized = false;
  static bool isHideBackButton = false;
  static bool isShowNotificationButton = false;
  static String homePath = '';
  static String loginPath = '';

  final bool _test;
  final IPlatformService _platformService;
  final GetTokenUsecase _getTokenUsecase;
  final ISessionService _sessionService;
  final IConfigurationRepository _configurationRepository;
  final IActivationRepository _activationRepository;
  final IEmployeeRepository _employeeRepository;
  final ISynchronizeClockingEventService _synchronizeClockingEventService;
  final InitializeFacialRecognitionUsecase _initializeFacialRecognitionUsecase;
  final MobileLoginUsecase _mobileLoginUsecase;
  final RequestDevicePermissionRepository _requestDevicePermissionRepository;
  final IInitClockUsecase _initClockUsecase;
  final GetLastVersionPrivacyPolicyUsecase _getLastVersionPrivacyPolicyUsecase;

  CollectorModuleService({
    required GetTokenUsecase getTokenUsecase,
    bool test = false,
    required IPlatformService platformService,
    required ISessionService sessionService,
    required IConfigurationRepository configurationRepository,
    required IActivationRepository activationRepository,
    required IEmployeeRepository employeeRepository,
    required ISynchronizeClockingEventService synchronizeClockingEventService,
    required InitializeFacialRecognitionUsecase
        initializeFacialRecognitionUsecase,
    required MobileLoginUsecase mobileLoginUsecase,
    required RequestDevicePermissionRepository
        requestDevicePermissionRepository,
    required IInitClockUsecase initClockUsecase,
    required GetLastVersionPrivacyPolicyUsecase
        getLastVersionPrivacyPolicyUsecase,
  })  : _getTokenUsecase = getTokenUsecase,
        _platformService = platformService,
        _test = test,
        _sessionService = sessionService,
        _configurationRepository = configurationRepository,
        _activationRepository = activationRepository,
        _employeeRepository = employeeRepository,
        _synchronizeClockingEventService = synchronizeClockingEventService,
        _initializeFacialRecognitionUsecase =
            initializeFacialRecognitionUsecase,
        _mobileLoginUsecase = mobileLoginUsecase,
        _requestDevicePermissionRepository = requestDevicePermissionRepository,
        _initClockUsecase = initClockUsecase,
        _getLastVersionPrivacyPolicyUsecase =
            getLastVersionPrivacyPolicyUsecase;

  @override
  Future<void> initialize({
    required EnvironmentEnum environment,
    required AppIdentfierEnum appIdentifier,
    String? fcmToken,
    bool hideBackButton = true,
    bool showNotificationButton = false,
    required String homePath,
    required String loginPath,
  }) async {
    appIdentfierEnum = appIdentifier;
    isHideBackButton = hideBackButton;
    isShowNotificationButton = showNotificationButton;
    CollectorModuleService.homePath = homePath;
    CollectorModuleService.loginPath = loginPath;

    await _requestDevicePermissionRepository.call();

    await loadEnvFile(
      environment: environment,
      test: _test,
    );

    try {
      await _sessionService.clean();

      _byPassSSLVerification();

      WidgetsFlutterBinding.ensureInitialized();

      Token? token = (await _getTokenUsecase.call(tokenType: TokenType.user));

      _getLastVersionPrivacyPolicyUsecase.call();

      EmployeeDto? employeeLocal;
      ActivationDto? activationLocal;
      ConfigurationDto? configurationLocal;
      if (token != null && token.username != null) {
        MobileLoginUsecaseReturn? mobileLoginUseReturn =
            await _mobileLoginUsecase.call(environment, token);

        if (mobileLoginUseReturn != null) {
          if (mobileLoginUseReturn.noInternetConnection) {
            // Else load local user info
            Configuration? configEntity =  await _configurationRepository.findByUsername(
              username: token.username!,
            );
            configurationLocal = ConfigurationMapper.fromEntityToDtoCollector(configEntity);

            if (configurationLocal != null) {
              Activation? activationEntity = await _activationRepository.findByEmployeeId(
                employeeId: configurationLocal.id!,
              );
              activationLocal = ActivationMapper.fromEntityToDtoCollector(activationEntity);
              
              var employeeEntity = await _employeeRepository.findById(
                id: configurationLocal.id!,
              );
              employeeLocal = EmployeeMapper.fromEntityToDtoCollector(employeeEntity);
            }
          } else {
            employeeLocal = mobileLoginUseReturn.employeeLocal;
            activationLocal = mobileLoginUseReturn.activationLocal;
            configurationLocal = mobileLoginUseReturn.configurationLocal;
          }
        }

        if (configurationLocal != null) {
        _sessionService.setLogedUser(
            configurationDto: configurationLocal,
            activationDto: activationLocal,
            employeeDto: employeeLocal,
            username: token.username,
          );
        }

        await _setConfig(token.accessToken, environment);

      }

      clock.ConfigService.instance.setEnvironment(
        environmentEnum: EnvironmentEnum.mapToClock(environment),
      );

      _initializeFacialRecognitionUsecase.call();

      // Initialize internal clock
      await _initClockUsecase.call();

      /// Defines the synchronization routine to be executed when the connection situation changes
      _platformService.connectivityStream().listen((event) {
        if (event) {
          _synchronizeClockingEventService.startSynchronize();
        }
      });

      /// Calls the synchronization routine at application startup
      _synchronizeClockingEventService.startSynchronize();

      _hasInitialized = true;
    } catch (e) {
      throw PontoMobileCollectorException('Error initializing module. $e');
    }
  }

  @override
  Future<void> finalize() async {
    _hasInitialized = false;
  }

  @override
  bool hasInitialized() {
    return _hasInitialized;
  }

  Future<bool> loadEnvFile({
    required EnvironmentEnum environment,
    required bool test,
  }) async {
    String environmentFile;
    switch (environment) {
      case EnvironmentEnum.test:
        environmentFile = 'packages/ponto_mobile_collector/environment_dev.env';
        break;
      case EnvironmentEnum.dev:
        environmentFile = 'packages/ponto_mobile_collector/environment_dev.env';
        break;
      case EnvironmentEnum.homolog:
        environmentFile = 'packages/ponto_mobile_collector/environment_hml.env';
        break;
      case EnvironmentEnum.prod:
        environmentFile =
            'packages/ponto_mobile_collector/environment_prod.env';
        break;
    }

    if (test) {
      dotenv.testLoad(
        fileInput: File('environment_dev.env').readAsStringSync(),
      );
    } else {
      await dotenv.load(fileName: environmentFile);
    }

    return Future.value(true);
  }

  void _byPassSSLVerification() {
    if (EnvironmentService.byPassSslVerificationStatic()) {
      HttpOverrides.global = MyHttpOverrides();
    }
  }

  /// Define library settings
  Future<void> _setConfig(
    String accesToken,
    EnvironmentEnum environmentEnum,
  ) async {
    clock.ConfigService.instance.setEnvironment(
      environmentEnum: EnvironmentEnum.mapToClock(environmentEnum),
    );

    clock.ConfigService.instance.setToken(token: accesToken);

    return Future.value();
  }

  @override
  String getHomePath() {
    return homePath;
  }

  @override
  void setHomePath(String home) {
    homePath = home;
  }

  @override
  String getLoginPath() {
    return loginPath;
  }

  @override
  AppIdentfierEnum getAppIdentfierEnum() {
    return appIdentfierEnum;
  }
}

// Custom HttpOverrides class to bypass SSL verification
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    HttpClient client = super.createHttpClient(context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }
}
