import 'dart:async';
import 'dart:developer';

import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../domain/entities/facial_recognition_message.dart';
import '../../../domain/enums/work_indicator_type.dart';
import '../../../domain/repositories/face_recognition_check_face_repository.dart';
import '../../../domain/repositories/face_recognition_register_company_repository.dart';
import '../../../domain/services/face_recognition/face_recognition_authenticate_service.dart';
import '../../../domain/services/face_recognition/face_recognition_download_service.dart';
import '../../../domain/services/face_recognition/face_recognition_settings_service.dart';
import '../../../domain/services/face_recognition/face_recognition_synchronization_service.dart';
import '../../../domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import '../../../domain/services/work_indicator_service.dart';
import '../../../domain/usecases/check_conection_usecase.dart';

class FaceRecognitionSdkAuthenticationService
    implements IFaceRecognitionSdkAuthenticationService {
  static final StreamController<bool> _initializeStream =
      StreamController<bool>.broadcast();
  static bool initializationIsRunning = false;
  late String companyId;

  final List<FacialRecognitionMessage> _messages = <FacialRecognitionMessage>[];
  final StreamController<FacialRecognitionMessage>
      _recognitionMessageBroadcastStream =
      StreamController<FacialRecognitionMessage>.broadcast();

  final FlutterGryfoLib _gryfoLib;
  final ISessionService _sessionService;
  final GetTokenUsecase _getTokenUsecase;
  final ISharedPreferencesService _sharedPreferencesService;

  final IPermissionService _permissionService;
  final FaceRecognitionSettingsService _settingsService;
  final FaceRecognitionAuthenticateService _faceRecognitionAuthenticateService;
  final FaceRecognitionRegisterCompanyRepository
      _faceRecognitionRegisterCompanyRepository;
  final FaceRecognitionDownloadService _faceRecognitionDownloadService;
  final FaceRecognitionSynchronizationService
      _faceRecognitionSynchronizationService;
  final FaceRecognitionCheckFaceRepository _faceRecognitionCheckFaceRepository;
  final WorkIndicatorService _workIndicatorService;
  final HasConnectivityUsecase _hasConnectivityUsecase;

  @override
  List<FacialRecognitionMessage> get messages => _messages.toList();

  @override
  FacialRecognitionMessage? get latestMessage => _messages.last;

  FaceRecognitionSdkAuthenticationService({
    required FlutterGryfoLib gryfoLib,
    required ISessionService sessionService,
    required IPermissionService permissionService,
    required FaceRecognitionSettingsService settingsService,
    required FaceRecognitionAuthenticateService
        faceRecognitionAuthenticateService,
    required FaceRecognitionRegisterCompanyRepository
        faceRecognitionRegisterCompanyRepository,
    required FaceRecognitionDownloadService faceRecognitionDownloadService,
    required FaceRecognitionSynchronizationService
        faceRecognitionSynchronizationService,
    required FaceRecognitionCheckFaceRepository
        faceRecognitionCheckFaceRepository,
    required GetTokenUsecase getTokenUsecase,
    required ISharedPreferencesService sharedPreferencesService,
    required WorkIndicatorService workIndicatorService,
    required HasConnectivityUsecase hasConnectivityUsecase,
  })  : _gryfoLib = gryfoLib,
        _sessionService = sessionService,
        _permissionService = permissionService,
        _settingsService = settingsService,
        _faceRecognitionAuthenticateService =
            faceRecognitionAuthenticateService,
        _faceRecognitionRegisterCompanyRepository =
            faceRecognitionRegisterCompanyRepository,
        _faceRecognitionDownloadService = faceRecognitionDownloadService,
        _faceRecognitionSynchronizationService =
            faceRecognitionSynchronizationService,
        _getTokenUsecase = getTokenUsecase,
        _sharedPreferencesService = sharedPreferencesService,
        _faceRecognitionCheckFaceRepository =
            faceRecognitionCheckFaceRepository,
        _workIndicatorService = workIndicatorService,
        _hasConnectivityUsecase = hasConnectivityUsecase {
    _initializeStream.add(initializationIsRunning);

    _gryfoLib.onMessage.listen(
      (event) async {
        if (event['code'] == 90) {
          log('FaceRecognitionSdkAuthenticationService: Sucesso');
        }
        final message = FacialRecognitionMessage.fromMap(event);
        _messages.add(message);
      },
    );

    _gryfoLib.recognizeEventStream.stream.listen((event) {
      if (event['code'] == 90) {
        log('FaceRecognitionSdkAuthenticationService: Sucesso');
      }
      final message = FacialRecognitionMessage.fromMap(event);
      _recognitionMessageBroadcastStream.add(message);
    });
  }

  @override
  bool getInitializationIsRunning() {
    return initializationIsRunning;
  }

  /// [delayToInit] Waiting time for facial recognition to initialize
  /// [forceFaceSync] Force session user face sync
  @override
  Future<void> initialize({
    Duration delayToInit = Duration.zero,
    bool forceFaceSync = false,
  }) async {
    bool hasCameraAccess =
        await _permissionService.requestDevicePermissionIfNotAllowed(
      permission: DevicePermissionEnum.camera,
    );

    if (hasCameraAccess) {
      initializationIsRunning = true;
      _initializeStream.add(initializationIsRunning);
      _workIndicatorService.addWorkIndicator(
        workIndicatorType: WorkIndicatorType.faceRecognitionInitialize,
      );
      
      await _init(
        delayToInit: delayToInit,
        forceFaceSync: forceFaceSync,
      );

      initializationIsRunning = false;
      _initializeStream.add(initializationIsRunning);
      _workIndicatorService.removeWorkIndicator(
        workIndicatorType: WorkIndicatorType.faceRecognitionInitialize,
      );
    }
  }

  Future<bool> _init({
    Duration delayToInit = Duration.zero,
    bool forceFaceSync = false,
  }) async {
    log('FaceRecognitionSdkAuthenticationService: Iniciando SDK de reconhecimento facial');

    try {
      if (!(await _settingsService.setSettings())) {
        log('FaceRecognitionSdkAuthenticationService: Falha ao setar configurações');
        return false;
      }
      log('FaceRecognitionSdkAuthenticationService: Configurações setadas');

      if (!(await _faceRecognitionAuthenticateService.authenticate())) {
        log('FaceRecognitionSdkAuthenticationService: Falha ao autenticar com o fornecedor');
        return false;
      }
      log('FaceRecognitionSdkAuthenticationService: Autenticado com sucesso');

      if (!(await _faceRecognitionDownloadService.downloadAIFiles())) {
        log('FaceRecognitionSdkAuthenticationService: Falha ao fazer download dos arquivos de IA');
        return false;
      }
      log('FaceRecognitionSdkAuthenticationService: Arquivos de IA baixados com sucesso');

      if (_sessionService.hasEmployee()) {
        companyId = await getCompany();

        if (!await _faceRecognitionRegisterCompanyRepository.call(
          companyId: companyId,
        )) {
          log('FaceRecognitionSdkAuthenticationService: Falha ao registrar empresa');
          return false;
        }

        log('FaceRecognitionSdkAuthenticationService: Iniciando validação de colaborador');

        String employeeId = _sessionService.getEmployeeId();
        String? faceRegisteredId = _sessionService.getEmployee().faceRegistered;
        bool faceIsInGryfoLocalDatabase =
            await _faceRecognitionCheckFaceRepository.call(
          employeeId: employeeId,
        );

        if (!faceIsInGryfoLocalDatabase || forceFaceSync) {
          //Pegar colaborador da sessão e validar o id de sincronia
          var faceIsRegisteredOnPlatform =
              faceRegisteredId == employeeId.replaceAll('-', '');
          
          if (faceIsRegisteredOnPlatform && await _hasConnectivityUsecase.call()) {
            log('FaceRecognitionSdkAuthenticationService: Iniciando sincronização de face para base local');
            var retries = 0;
            var bool = false;

            while (retries < 9) {
              log('FaceRecognitionSdkAuthenticationService: Tentativa $retries de sincronizar a face do colaborador');
              if (retries != 0) {
                delayToInit = const Duration(seconds: 30);
              }

              bool = await Future.delayed(
                delayToInit,
                () => _faceRecognitionSynchronizationService
                    .syncFaceEmployee(employeeId),
              );

              if (bool) {
                log('FaceRecognitionSdkAuthenticationService: Face sincronizada');
                break;
              }
              log('FaceRecognitionSdkAuthenticationService: Erro ao tentar sincronizar, nova tentativa em 30 segundos');
              retries++;
            }
          }
        } else {
          log('FaceRecognitionSdkAuthenticationService: Face já sincronizada');
        }
      }
    } catch (e) {
      log(e.toString());
    }

    return true;
  }

  @override
  Stream<bool> getInitializeStream() {
    return _initializeStream.stream;
  }

  @override
  Future<void> close() async {
    _initializeStream.close();
    _recognitionMessageBroadcastStream.close();
  }

  @override
  FlutterGryfoLib getGryfoService() {
    return _gryfoLib;
  }

  @override
  Stream<FacialRecognitionMessage> getFacialRecognitionMessageStream() {
    return _recognitionMessageBroadcastStream.stream;
  }

  Future<String> getCompany() async {
    var token = (await _getTokenUsecase.call(tokenType: TokenType.key));
    var companyId = _sessionService.getCompanyId();
    if (token == null) {
      await _sharedPreferencesService.setSessionCompanyId(companyId: companyId);
      return companyId;
    } else {
      String? companyIdSharedPreferences =
          await _sharedPreferencesService.getSessionCompanyId();
      if (companyIdSharedPreferences != null) {
        return companyIdSharedPreferences;
      }
    }
    return companyId = '';
  }
}
